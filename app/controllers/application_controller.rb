require './config/environment'
require 'sinatra/flash'
class ApplicationController < Sinatra::Base
  
  # use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end
  

  get '/' do 
     erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
    def is_staff_doctor?
      session[:user_type]
    end

  end 


end