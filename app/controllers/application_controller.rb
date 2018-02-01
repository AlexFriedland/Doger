#walks belong to dogs

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

  get "/dogs/newdog" do
    erb :'/dogs/create_dog'
  end

  get '/dogs/:id' do
    @dog = Dog.find_by_id(params[:id])
    if @dog.user.id == session[:user_id]
      erb :'/dogs/show'
    else
      redirect '/users/show'
    end
  end

  #patch / post ?
  patch "/dogs/:id" do
    @dog = Dog.find_by_id(params[:id])

    if @dog.user.id == session[:user_id]

      if complete_dog?
        @dog.name = params[:dog][:name]
        @dog.walk_ids.clear
        @dog.walk_ids = params[:dog][:walk_ids]
        @dog.save

        if params[:walk][:distance] != "" && params[:walk][:from] != "" && params[:walk][:to] != ""
          @walk = Walk.create(day: "#{Time.now}", from: params[:walk][:from], to: params[:walk][:to], miles: params[:walk][:distance])
          @dog.walks << @walk
          @walk.dogs << @dog
        end
      end
    end
    redirect to "/users/show"
  end

  delete '/dogs/:id/delete' do
    @dog = Dog.find_by_id(params[:id])
    @dog.destroy
    @user = User.find_by_id(session[:user_id])
    erb :'/users/show'
  end

  get "/walks/:id/edit" do
    if logged_in?
      @walk = Walk.find_by_id(params[:id])
      erb :'/walks/edit_walk'
    else
      redirect to "/login"
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
      @walk = Walk.find_by_id(params[:id])
      erb :'/walks/show_walk'
    else
      redirect to "/login"
    end
  end

  get "/walks" do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @dogs = @user.dogs
      erb :'/walks/walks'
    else
      redirect to "/login"
    end
  end

  get '/create_dog' do
    erb :'/dogs/create_dog'
  end

  post "/newdog" do
    if logged_in? && complete_dog?
      @dog = Dog.create(name: params["name"])
      @user = User.find_by_id(session[:user_id])
      @user.dogs << @dog

      if params[:dog]
        @dog.walk_ids = params[:dog][:walk_ids]
      end

      if params[:walk][:distance] != "" && params[:walk][:from] != "" && params[:walk][:to] != ""
        @walk = Walk.create(day: "#{Time.now}", from: params[:walk][:from], to: params[:walk][:to], miles: params[:walk][:distance])
        @dog.walks << @walk
        @walk.dogs << @dog
      end

      redirect to "/show"
    else
      redirect to "/dogs/newdog"
    end
  end

  # Helper Methods
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def complete_dog?
      params["name"] != ""
    end
  end
end
