require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, 'gsauydfiq4678rqoye89y9'
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:email]
    end

    def login(email, password)
      user  = User.find_by(email: email)
      if user && user.authenticate(password)
        session[:email] = user.email
      else
        flash[:error] = ["Invalid Credientals"]
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end
  end
end
