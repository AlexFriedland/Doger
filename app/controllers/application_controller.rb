require './config/environment'
require "./app/models/user"
require "./app/models/walk"
require "./app/models/dog"

require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
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

  get "/newdog" do
    erb :'/dogs/create_dog'
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

  get "/walks/:id/edit" do
    if logged_in?
      @walk = Walk.find_by_id(params[:id])
      erb :'/walks/edit_walk'
    else
      redirect to "/login"
    end
  end

  patch "/walks/:id" do
    @walk = Walk.find_by_id(params[:id])
    if complete_ride?
      @walk.from_location = params["from_location"]
      @walk.to_location = params["to_location"]
      @walk.miles = params["miles"]
      @walk.day = params["day"]
      @walk.save

      @walk.feelings.each_with_index do |feeling, i|
        feeling.update(feeling_description: params["feelings"][i])
      end

      redirect to "/walks/#{@walks.id}"
    else
      redirect to "/walks/#{@walk.id}/edit"
    end
  end

  get "/walks/new" do
    if logged_in?
      erb :'/walks/create_walk'
    else
      redirect to "/login"
    end
  end

  get "/walks/:id" do
    if logged_in?
      @walk = Walk.find(params[:id])
      erb :'/walks/show_walk'
    else
      redirect to "/login"
    end
  end

  get "/walks" do
    if logged_in?
      @walk = current_user
      erb :'walks/walks'
    else
      redirect to "/login"
    end
  end

  get '/failure' do
    erb :'/failure'
  end

  post "/signup" do
    @user = User.new(email: params["email"], username: params["username"], password_digest: params["password"])
    if @user.username != "" && @user.password != "" && @user.save
      session[:user_id] = @user.id
      redirect "/users/show"
    else
      redirect "/failure"
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/walks"
    else
        redirect "/failure"
    end
  end

  post "/rides" do
    if logged_in? && complete_ride?
      @ride = Ride.create(
        from_location: params["from_location"],
        to_location: params["to_location"],
        miles: params["miles"],
        day: params["day"],
        user_id: session[:user_id]
      )
      params["feelings"].each do |feeling|
        @ride.feelings << Feeling.create(feeling_description: feeling)
      end
      redirect to "/rides"
    else
      redirect to "/rides/new"
    end
  end

  delete "/rides/:id/delete" do
    @ride = Ride.find(params[:id])
    if current_user.id == @ride.user_id
      @ride.delete
    end
    redirect to "/rides"
  end


  # Helper Methods
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def complete_ride?
      params["from_location"] != "" &&
      params["to_location"] != "" &&
      params["miles"] != "" &&
      params["day"] != ""
    end
  end

end
