require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if session[:user_id] != nil
      redirect to '/textbooks'
    end
    erb :index
  end

  helpers do
    def logged_in?
      if session[:user_id] == nil
        redirect to '/login'
      end
      true
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end
end
