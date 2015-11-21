require 'minitest/autorun'
require 'sinatra/activerecord'

require './models/user'
require './models/tweet'
require './models/timeline'
require './models/follow'

describe Tweet do
    
  before do
    @test_user = User.create(name: 'some_username', email: 'fakeemail@email.com', password: 'deis')
  end
    
  after do
    User.delete(@test_user.id)
  end
    
  it 'can be made by a user' do
    tweet = Tweet.make_tweet(@test_user, 'content here', Time.now)
    tweet.wont_equal 'Sorry, there was an error!'
    Tweet.destroy(tweet.id)
  end

  #content is 150 characters long
  it 'has no more than 140 characters' do
    tweet = Tweet.make_tweet(@test_user, '0123456789' * 150, Time.now)
    tweet.must_equal 'Sorry, there was an error!'
  end
    
end


