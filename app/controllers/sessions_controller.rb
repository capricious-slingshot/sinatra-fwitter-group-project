class SessionsController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :"sessions/login"
    else
      redirect '/tweets'
    end
  end

  post '/sessions' do
    login(params[:email], params[:password])
    flash[:success] = "Welcome, #{session[:email]}"
    redirect '/tweets'
  end

  get '/logout' do
    logout!
    redirect '/login'
  end

end
