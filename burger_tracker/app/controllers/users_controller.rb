class UsersController < ApplicationController
  end
    render json: current_user
  def index
  before_action :authenticate_user!
end
