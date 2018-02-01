require './config/environment'
require "./app/models/user"
require "./app/models/walk"
require "./app/models/dog"

require 'pry'

class UserController < ApplicationController

  get "/" do
    if logged_in?
      redirect to "/users/show"
    end
  	erb :index
  end

  get "/signup" do
    if logged_in?
      @user = User.find_by_id(params[:user_id])
      redirect to "/users/show"
    end
    erb :'/users/create_user'
  end

  get "/users/show" do
    @user = User.find_by_id(session[:user_id])
    erb :'/users/show'
  end

  get "/login" do
    if logged_in?
      redirect to "/users/show"
    end
    erb :'/users/login'
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect to "/login"
    end
  end

end
