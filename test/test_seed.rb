require 'faker'

module NanoTwitter
  module Test
    module Seed

      def self.registered(app)

        app.get '/test/seed/:num' do |num|
          num.to_i.times do |i|
            saved = false
            until saved
              name = Faker::Internet.user_name
              email = Faker::Internet.email(name)
              u = User.new(name: name, email: email, password: 'deis')
              saved = u.save
            end
          end
          "Created #{num} Users"
        end
      end
    end
  end
end
