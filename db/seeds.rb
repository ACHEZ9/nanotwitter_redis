require 'faker'

10.times do |i|
  name = Faker::Internet.user_name
  email = Faker::Internet.email(name)
  
  user = User.create(name: name, email: email, password: "deis")

  # rand(0..10).times do |j|
  #   Tweet.create(user_id: user.id, content: Faker::Hacker.say_something_smart)
  # end
end


all_users = User.all

50.times do
  pair = all_users.sample(2)

  unless pair[0].followers.exists?(pair[1].id)
    pair[0].followers << pair[1]
  end
end

all_users.each do |user|
  rand(0..10).times do
    Tweet.create(user_id: user.id, :user_name=>user.name, content: Faker::Hacker.say_something_smart, tweeted_at: Faker::Time.backward(30, :all))
  end
end




