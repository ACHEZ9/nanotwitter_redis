class Follow < ActiveRecord::Base
	belongs_to :user
	belongs_to :followed_user, :class_name => "User"

    after_create :rebuild_redis
    after_destroy :rebuild_redis

    private

    def rebuild_redis
        $redis.del("timeline:user:#{user.id}")
        user.timeline
    end

    def add_followed_tweets

        tweets = self.followed_user.tweets
        tweets.each do |tweet|
            Timeline.create(user_id: self.user_id, tweet_id: tweet.id)
        end
    end

    def remove_followed_tweets
        tweet_ids = self.followed_user.tweets.pluck(:id)
        Timeline.where(user_id: self.user_id, tweet_id: tweet_ids).destroy_all
    end
    
    def self.follow(follower, followed)
        if followed.nil?
            'Sorry, there was an error'
        elsif follower.id == followed.id
            'Cannot follow yourself'
        else
            follower.followed_users << followed
        end
    end

    def self.unfollow(unfollower, unfollowed)
        if unfollowed.nil?
            'Sorry, there was an error'
        else
            unfollower.followed_users.destroy(unfollowed)
        end
    end
end