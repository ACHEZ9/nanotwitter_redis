class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :timelines, dependent: :destroy
  has_many :users, :through => :timeline

  after_create :add_to_timelines
  validates :user, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  private

  def add_to_timelines
    #Adding own tweets to timeline currently, can evaluate this
    Timeline.create(user_id: self.user_id, tweet_id: self.id)
    user.followers.each do |follower|
      Timeline.create(user_id: follower.id, tweet_id: self.id)
    end
  end
  
  def self.make_tweet(user, content, tweeted_at)
    if user.nil?
      'Sorry, there was an error'
    end
  
    tweet = Tweet.new(:user_id=>user.id, :user_name=>user.name, :content=>content, tweeted_at: tweeted_at)

    if tweet.save
      tweet
    else
      'Sorry, there was an error!'
    end
  end

end