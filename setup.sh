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



function define_models {
  # Define models
  rails generate devise User 
  rake db:migrate
  rails generate model Address street_addr:string street:string area:string city:string post_code:string phone_no:string
  rails generate model Restaurant name:string address:references franchise:string
  rails generate model Burger description:string restaurant:references  price:decimal{5.2} rating:integer
  rails generate model Deal label:string discount_rate:decimal money_off:decimal start_date:datetime end_date:datetime restaurant:references burger:references
  rake db:migrate
}

# construction starts here
rails new $PROJECT
#set up basic model definition
define_models

