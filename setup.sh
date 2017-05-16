#!/bin/sh
PROJECT="burger_tracker"
DIRECTORY=$PROJECT

# check if project present
if [ -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "Directory $DIRECTORY found, remove/rename to use this script, exiting..."
  exit
fi


# check if spring pre-loader still running from previous run, interferes with a new rails run
SPRINGS_TO_KILL=`ps | grep spring | grep server | cut -d " " -f 1`
echo "found spring server pre-loaders $SPRINGS_TO_KILL still running, attempting to stop them..."
kill $SPRINGS_TO_KILL

function add_line_to_file {
  echo $1 $2 $3
  file_name=$1
  line_number=$2
  new_line=$3
  awk 'NR=='$line_number'{print; print "'"$new_line"'" } NR!='$line_number' ' $file_name > tmp.tmp
  mv tmp.tmp $file_name
}

function delete_line_from_file {
  file_name=$1
  line_number_to_delete=$2
  awk 'NR!='$line_number_to_delete' ' $file_name > tmp.tmp
  mv tmp.tmp $file_name
}

function define_models {
  # Define models
  rails generate devise User 
  rake db:migrate
  rails generate model Address street_addr:string street:string area:string city:string post_code:string phone_no:string
  rake db:migrate
  rails generate model Restaurant name:string address:references franchise:string
  rake db:migrate
  rails generate model Burger description:string restaurant:references  price:decimal{5.2} rating:integer
  rake db:migrate
  rails generate model Deal label:string discount_rate:decimal money_off:decimal start_date:datetime end_date:datetime restaurant:references
  rake db:migrate

  # set up jointable for burgers in a deal
  rails generate model BurgerDeal burger_id:integer deal_id:integer
  add_line_to_file app/models/burger_deal.rb 1 "  belongs_to :burger" 
  add_line_to_file app/models/burger_deal.rb 2 "  belongs_to :deal" 



  # a deal can have multiple burger_deal entries
  add_line_to_file app/models/deal.rb 2 "  has_many :burger_deals" 

  # a deal can have 1 to many burgers
  add_line_to_file app/models/deal.rb 3 "  has_many :burgers, through: :burger_deals, source: :burger" 

  # a burger can appear in 0 to many deals
  add_line_to_file app/models/burger.rb 2 "  has_many :deals, through: :burger_deals, source: :deal" 

  # a restaurant can have 0 to many deals
  add_line_to_file app/models/restaurant.rb 2 "  has_many :deals" 
  # a restaurant belongs to one address, so an address can only have one restaurant
  add_line_to_file app/models/address.rb 1 "  has_one :restaurant" 


  # run migrations
  rake db:migrate
}

function install_devise {
# install devise gem
  echo "installing devise based authentication"
  add_line_to_file Gemfile 2 "# User devise for multi-user authentication"
  add_line_to_file Gemfile 3 "gem 'devise'"
  bundle
  rails generate devise:install
}

function install_awesome_print {
  echo "adding awesome print"
  add_line_to_file Gemfile 2 "# pretty-print JSON objects in command line"
  add_line_to_file Gemfile 3 "gem 'awesome_print'"
  
}

function setup_fixtures_for_test {
  # Edit(replace) users.yml to ensure tests don't fail with user database update errors
  # Read about fixtures at http://api.rubyonrails.org/classes/ActiveRecord/FixtureSet.html

cat - <<EOF > test/fixtures/users.yml
  # This model initially had no columns defined.  If you add columns to the
  # model remove the '{}' from the fixture names and add the columns immediately
  # below each fixture, per the syntax in the comments below
  # 
  # Updates to allow tests to run
  one:
    email: user1@test.com
  #
  two:
    email: user2@test.com
EOF

cat - <<EOF > test/fixtures/addresses.yml
# Read about fixtures at http://api.rubyonrails.org/classes/ActiveRecord/FixtureSet.html

one:
  street_addr: 1
  street: The Street
  area: the Area
  city: The City
  post_code: EH1 2AB
  phone_no: 1234 5678

two:
  street_addr: 2
  street: The other strees
  area: Blank
  city: City
  post_code: EH2 3CD
  phone_no: 555 555 5555

EOF

cat - <<EOF > test/fixtures/restaurants.yml
# Read about fixtures at http://api.rubyonrails.org/classes/ActiveRecord/FixtureSet.html

one:
  name: Milliways
  address_id: End of Universe
  franchise: h2g2

two:
  name: MyString
  address_id: 
  franchise: MyString
EOF
}

function setup_routes {
  echo "adding routes ..."
  add_line_to_file config/routes.rb 2 ""
  add_line_to_file config/routes.rb 3 '  scope path: \"api\", defaults: {format: :json} do'
  add_line_to_file config/routes.rb 4 "    resources :restaurants"
  add_line_to_file config/routes.rb 5 "    resources :burgers"
  add_line_to_file config/routes.rb 6 "    resources :deals"
  add_line_to_file config/routes.rb 7 "    resources :addresses"
  add_line_to_file config/routes.rb 8 "  end"
  add_line_to_file config/routes.rb 9 ""
  add_line_to_file config/routes.rb 10 "  resources :users"
  add_line_to_file config/routes.rb 11 ""

  delete_line_from_file config/routes.rb 2
  add_line_to_file config/routes.rb 1 ""
  add_line_to_file config/routes.rb 2 "  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}"
}

function setup_tests {
  # call after setting up seeds.rb
  # install and run unit test files from original project
  cp ../specs/models/*.rb test/models

  # add devise test helpers to allow controller tests to run
  cat - <<EOF >> test/test_helper.rb
class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
EOF

  # install test users to avoid testing errors due to undefined users with devise
  setup_fixtures_for_test

  # get test database in line with dev database before running tests
  rake RAILS_ENV=test db:migrate
  # seed test database 
  rake RAILS_ENV=test db:seed 
}

function setup_controllers {
  # generate and then edit controllers.  
  # Add authentication requirement to before action.
  # Some overwriting of scaffold methods to ensure json returned
  # without adding .json to routes from client
  rails generate scaffold_controller Restaurant --no-jbuilder
  add_line_to_file app/controllers/restaurants_controller.rb 7 "    render json: @restaurants"
  
  add_line_to_file app/controllers/restaurants_controller.rb 13 "    @restaurant = Restaurant.find(params[:id])"
  add_line_to_file app/controllers/restaurants_controller.rb 14 "    render json: @restaurant"
  sed -i '' 's/before_action /before_action :authenticate_user!, /' app/controllers/restaurants_controller.rb 

  rails generate scaffold_controller Burger --no-jbuilder
  add_line_to_file app/controllers/burgers_controller.rb 7 "    render json: @burgers"
  add_line_to_file app/controllers/burgers_controller.rb 13 "    @burger = Burger.find(params[:id])"
  add_line_to_file app/controllers/burgers_controller.rb 14 "    render json: @burger"
  sed -i '' 's/before_action /before_action :authenticate_user!, /' app/controllers/burgers_controller.rb 

  rails generate scaffold_controller Deal --no-jbuilder
  add_line_to_file app/controllers/deals_controller.rb 7 "    render json: @deals"
  add_line_to_file app/controllers/deals_controller.rb 13 "    @deal = Deal.find(params[:id])"
  add_line_to_file app/controllers/deals_controller.rb 14 "    render json: @deal"
  sed -i '' 's/before_action /before_action :authenticate_user!, /' app/controllers/deals_controller.rb 

  rails generate scaffold_controller Address --no-jbuilder
  add_line_to_file app/controllers/addresses_controller.rb 7 "    render json: @address"
  add_line_to_file app/controllers/addresses_controller.rb 13 "    @address = Address.find(params[:id])"
  add_line_to_file app/controllers/addresses_controller.rb 14 "    render json: @address"
  sed -i '' 's/before_action /before_action :authenticate_user!, /' app/controllers/addresses_controller.rb 

  # add session and registration controller for user control with devise
  rails generate controller Sessions
  add_line_to_file app/controllers/sessions_controller.rb 1 "    respond_to :json"

  rails generate controller Registrations
  add_line_to_file app/controllers/registrations_controller.rb 1 "    respond_to :json"



  # copy reference controller file
  # cp ../controllers/restaurants_controller.rb app/controllers
}
# construction starts here

rails new $PROJECT
cd $PROJECT

# JSON object prettifier for command line
install_awesome_print

# add devise gem to rails for authentication
install_devise

#set up basic model definition
define_models

# install seeds file (amended copy of original seeds, updated some field names)
cat ../db/seeds_stub.rb >> db/seeds.rb
rake db:seed

# prepare test environment
setup_tests

# run unit tests
echo "running unit tests..."
rake test test/models

# setup routes
setup_routes

# setup then test controllers
setup_controllers

# controller tests need a signed in user to work
add_line_to_file test/controllers/addresses_controller_test.rb 5   "    sign_in users(:one)"
add_line_to_file test/controllers/burgers_controller_test.rb 5     "    sign_in users(:one)"
add_line_to_file test/controllers/deals_controller_test.rb 5       "    sign_in users(:one)"
add_line_to_file test/controllers/restaurants_controller_test.rb 5 "    sign_in users(:one)"


rake test test/controllers
