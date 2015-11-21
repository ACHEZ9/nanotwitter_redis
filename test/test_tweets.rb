require 'faker'

module NanoTwitter
  module Test
    module Tweets

      def self.registered(app)

        app.get '/test/tweets/:num' do |num|
          user = User.where(name: 'testuser').first
          num.to_i.times do |i|
            Tweet.create(user_id: user.id, user_name: user.name,
                         content: Faker::Hacker.say_something_smart,
                         tweeted_at: Faker::Time.backward(30, :all))
          end
          "Created #{num} Tweets"
        end
      end
    end
  end
end
