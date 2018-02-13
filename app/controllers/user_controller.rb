require './config/environment'
require "./app/models/user"
require "./app/models/walk"
require "./app/models/dog"

require 'pry'

class UsersController < ApplicationController

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

  post "/signup" do
    if User.all.any? {|user| user.username == params["user"]["username"]}
      redirect "/failure"
    else

    @user = User.new(params[:user])

      if @user.username != "" && @user.password != "" && @user.save
        session[:user_id] = @user.id
        redirect "/users/show"
      else
        redirect "/failure"
      end
    end
  end

  get "/show" do
      @user = User.find_by_id(session[:user_id])
      erb :"/users/show"
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/show"
    else
        redirect "/failure"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def complete_user?
      params["name"] != ""
      params["password"] != ""
    end
  end

end
