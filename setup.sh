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

function define_models {
  # Define models
  rails generate devise User 
  rake db:migrate
  rails generate model Address street_addr:string street:string area:string city:string post_code:string phone_no:string
  rails generate model Restaurant name:string address:references franchise:string
  rails generate model Burger description:string restaurant:references  price:decimal{5.2} rating:integer
  rails generate model Deal label:string discount_rate:decimal money_off:decimal start_date:datetime end_date:datetime restaurant:references burger:references
  rake db:migrate
  # a deal can have 1 to many burgers
  add_line_to_file app/models/deal.rb 3 "  has_many :burgers" 
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

function setup_users_for_test {
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

# install and run unit test files from original project
cp ../specs/models/*.rb test/models
# install test users to avoid testing errors due to undefined users with devise
setup_users_for_test
echo "running unit tests..."
rake test test/models

