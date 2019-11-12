class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'tweets/index', locals: { tweets: Tweet.all.reverse }
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      flash[:error] = ['You Must Be Logged in to Make Tweets']
      redirect '/login'
    end
  end

  post '/tweets' do
    user = User.find_by(email: session[:email])
    tweet = Tweet.new(content: params[:content], user_id: user.id)
    if tweet.valid? && tweet.errors.empty?
      tweet.save
      redirect '/tweets'
    else
      flash[:error] = tweet.errors.full_messages
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      erb :'/tweets/show', locals: {tweet: Tweet.find_by(id: params[:id])}
    else
      flash[:error] = ['You Must Be Logged in to Edit This Tweet']
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      erb :'/tweets/edit', locals: {tweet: Tweet.find_by(id: params[:id])}
    else
      flash[:error] = ['You Must Be Logged in to Edit This Tweet']
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by(id: params[:id])
    tweet.update(content: params[:content])
    if tweet.valid? && tweet.errors.empty?
      tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      flash[:error] = tweet.errors.full_messages
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find_by(id: params[:id])
    # binding.pry
    if logged_in? && session[:email] = tweet.user.email
      tweet.delete
      flash[:success] = "Tweet Succefully Deleted"
      redirect "/tweets"
    else
      flash[:error] = ['You Must Be Logged in to Edit This Tweet']
      redirect '/login'
    end
  end
end
