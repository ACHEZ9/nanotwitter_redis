require 'sinatra'
require 'newrelic_rpm'
require 'sinatra/activerecord'
require './config/environments' # database configuration
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/test/test*.rb'].each {|file| require file }
enable :sessions

after {ActiveRecord::Base.connection.close}

register NanoTwitter::Test::Reset
register NanoTwitter::Test::Tweets
register NanoTwitter::Test::Seed
register NanoTwitter::Test::FollowTest


# Some global configurations
configure do
  set :version, '0.5'
  set :app_name, 'Nano Twitter'
  set :authors, ['Allan Chesarone', 'Keigh Rim', 'Shu Chen', 'Vladimir Susaya']
end

# For loader.io verification
get '/loaderio-a299d935be12bb2bf88aa251e89a7ee1/' do
    'loaderio-a299d935be12bb2bf88aa251e89a7ee1'
end

get '/redis/add' do
  10.times do |i|
    $redis.rpush("list", i)
  end
  "Added to list"
end

get '/redis/get' do
  $redis.lrange("list", 0, -1)
end

get '/' do
  redirect '/timeline'
end

post '/login' do
  username = params[:name]
  password = params[:password]
  u = User.find_by(name: username, password: password)
  if u.nil?
    #add a redirect to a invalid login page
    'Invalid login credentials'
  else
    session[:logged_in_user_id] = u.id
    session[:logged_in_user_name] = u.name
    redirect '/'
  end
end

get '/logout' do
  session[:logged_in_user_id] = nil
  session[:logged_in_user_name] = nil
  redirect '/'
end

get '/register' do
  erb :register
end

post '/register' do
  new_user = User.new(params)
  if new_user.save
    session[:logged_in_user_id] = new_user.id
    session[:logged_in_user_name] = new_user.name
    redirect '/'
  else
    'Sorry, there was an error!'
  end
end

post '/tweet' do
  user = logged_in_user
  @tweet = Tweet.make_tweet(user, params[:content], Time.now)
  redirect back
end

get '/profile' do
  @user = logged_in_user
  if @user.nil?
    redirect '/register'
  else
    @tweets = @user.tweets.order(tweeted_at: :desc)
    erb :profile
  end
end

get '/timeline' do
  if session[:logged_in_user_name].nil?
    if $redis.exists("timeline:recent:50")
      @tweets = $redis.lrange("timeline:recent:50", 0, -1).map{|t| Tweet.new(JSON.parse(t))}
    else
      @tweets = Tweet.all.order(tweeted_at: :desc).take(50)
      @timeline = @tweets.map{|t| t.to_json}
      $redis.rpush("timeline:recent:50", @timeline)
    end
  else
    @tweets = logged_in_user.timeline
  end
  erb :timeline
end

post '/follows' do
    logged_in_user.follow(User.find_by_id(params[:user_id]))
    redirect back
end

post '/unfollows' do
    logged_in_user.unfollow(User.find_by_id(params[:user_id]))
    redirect back
end

get '/profile/:user_name' do |user_name|
  if user_name ==  session[:logged_in_user_name]
    redirect '/profile'
  else
    @user = User.where(name: user_name).first
    if @user.nil?
      "Oops, user \"#{user_name}\" does not exist"
    else
      @is_current_user = false
      if !logged_in_user.nil?
        is_following = logged_in_user.followed_users.include?(@user)
      end
      if is_following
        @following = true
      else
        @following = false
      end
      @tweets = @user.tweets.order(tweeted_at: :desc)
      erb :profile
    end
  end
end

def logged_in_user
  User.find_by_id(session[:logged_in_user_id])
end

