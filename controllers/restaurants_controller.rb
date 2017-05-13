class RestaurantsController < ApplicationController
  def index
    restaurants = Restaurant.all
    render restaurants
  end
end
