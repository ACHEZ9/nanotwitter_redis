class AddUserNameToTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :user_name, :string
  end
end
