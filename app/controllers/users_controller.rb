class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.valid? && user.errors.empty?
      user.save
      login(params[:email], params[:password])
      flash[:success] = "User Successfully Created"
      redirect '/tweets'
    else
      flash[:error] = user.errors.full_messages
      redirect '/signup'
    end
  end

  get "/users/:slug" do
    erb :'users/show', locals: {user: User.find_by(username: params[:slug])}
  end

end
