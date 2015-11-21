module NanoTwitter
  module Test
    module FollowTest

      def self.registered(app)

        app.get '/test/follow/:num' do |num|
          testuser = User.find_by(name: 'testuser')
          if testuser.nil?
            # TODO need a error page
            'No test user registered. Going back to main in 5 secs.'
            sleep(5)
            400
          end
          all_users = (1..User.count).to_a    # DB index starts from 1, not 0
          all_users.delete(testuser.id)
          num.to_i.times do |i|
            if all_users.size == 0
              400
            end
            follower_id = all_users.delete_at(rand(all_users.count))
            follower = User.find_by_id(follower_id)
            follower.followed_users << testuser
          end
          "Created #{num} Follows for testuser"
        end

      end
    end
  end
end


