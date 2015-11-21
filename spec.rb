require 'minitest/autorun'
require 'sinatra/activerecord'

require './models/user'
require './models/tweet'
require './models/timeline'
require './models/follow'

describe User do

  before do
    @test_user = User.create(name: "some_username", email: "fakeemail@email.com", password: "deis")
    @test_user_2 = User.create(name: "followed_username", email: "fakeemail2@email.com", password: "deis")
  end

  after do
    User.delete(@test_user.id)
    User.delete(@test_user_2.id)
  end

  it "has a required parameters" do
    @test_user.name.wont_be_nil && @test_username.email.wont_be_nil
  end

  it "can follow another user" do
    @test_user.follow(@test_user_2)
    @test_user.followed_users.include?(@test_user_2).must_equal true
  end

  it "cannot follow itself" do
    @test_user.follow(@test_user)
    @test_user.followed_users.include?(@test_user).must_equal false
  end

  it "can unfollow another user" do
    @test_user.follow(@test_user_2)
    @test_user.followed_users.include?(@test_user_2).must_equal true
    @test_user.unfollow(@test_user_2)
    @test_user.followed_users.include?(@test_user_2).must_equal false
  end
    
end


describe Tweet do
    
  before do
    @test_user = User.create(name: "some_username", email: "fakeemail@email.com", password: "deis")
  end
    
  after do
    User.delete(@test_user.id)
  end
    
  it "can be made by a user" do
    tweet = Tweet.make_tweet(@test_user, "content here", Time.now)
    tweet.wont_equal 'Sorry, there was an error!'
    Tweet.destroy(tweet.id)
  end
	
  #content is 150 characters long
  it "has no more than 140 characters" do
    tweet = Tweet.make_tweet(@test_user, "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789", Time.now)
    tweet.must_equal 'Sorry, there was an error!'
  end
    
end

#integration test
describe "Integration - following" do
    
  before do
    @test_user = User.create(name: "some_username", email: "fakeemail@email.com", password: "deis")
    @test_user_2 = User.create(name: "followed_username", email: "fakeemail2@email.com", password: "deis")
  end
    
  after do
    User.delete(@test_user.id)
    User.delete(@test_user_2.id)
  end
    
  it "let's a user follow another user, and adds that user's tweets to the first user's timeline" do
    user2_tweet = Tweet.make_tweet(@test_user_2, "test content by user 2", Time.now)
    @test_user.follow(@test_user_2)
    @test_user.followed_users.include?(@test_user_2).must_equal true
    timeline_record = Timeline.where(user_id: @test_user.id)
    added_tweet_id = timeline_record.first.tweet_id
    added_tweet = Tweet.find(added_tweet_id)
    added_tweet.content.must_equal "test content by user 2"
    
    Tweet.destroy(user2_tweet.id)
  end
  
  it "let's a user unfollow another user, and removes that user's tweets to the first user's timeline" do
      user2_tweet = Tweet.make_tweet(@test_user_2, "test content by user 2", Time.now)
      @test_user.follow(@test_user_2)
      @test_user.followed_users.include?(@test_user_2).must_equal true
      
      timeline_record = Timeline.where(user_id: @test_user.id)
      added_tweet_id = timeline_record.first.tweet_id
      added_tweet = Tweet.find(added_tweet_id)
      added_tweet.content.must_equal "test content by user 2"
      @test_user.unfollow(@test_user_2)
      @test_user.followed_users.include?(@test_user_2).must_equal false
      
      timeline_record = Timeline.where(user_id: @test_user.id)
      timeline_record.first.must_be_nil
      
      Tweet.destroy(user2_tweet.id)
  end

end

