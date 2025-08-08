class Api::V1::UsersController < ApplicationController
#   before_action :authenticate_user!, except: [:create]
  def index
    @users = User.all
    render json: { message: "All users", data: @users }
  end
  
  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
