require 'minitest/autorun'
require 'sinatra/activerecord'

require './models/user'
require './models/tweet'
require './models/timeline'
require './models/follow'

describe User do

  before do
    @test_user = User.create(name: 'some_username', email: 'fakeemail@email.com', password: 'deis')
    @test_user_2 = User.create(name: 'followed_username', email: 'fakeemail2@email.com', password: 'deis')
  end

  after do
    User.delete(@test_user.id)
    User.delete(@test_user_2.id)
  end

  it 'has a required parameters' do
    @test_user.name.wont_be_nil
    @test_user.email.wont_be_nil
  end

  it 'can follow another user' do
    @test_user.follow(@test_user_2)
    @test_user.followed_users.include?(@test_user_2).must_equal true
  end

  it 'cannot follow itself' do
    @test_user.follow(@test_user)
    @test_user.followed_users.include?(@test_user).must_equal false
  end

  it 'can unfollow another user' do
    @test_user.follow(@test_user_2)
    @test_user.followed_users.include?(@test_user_2).must_equal true
    @test_user.unfollow(@test_user_2)
    @test_user.followed_users.include?(@test_user_2).must_equal false
  end
    
end

