#walks belong to dogs


require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
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
