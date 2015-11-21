class CreateTweet < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
  		t.integer :user_id
  		t.string :content
  		t.datetime :tweeted_at
  	end
  end
end




# table tweets
# 	id: integer primary_key
# 	user_id: integer foreign_key
# 	content: string
# 	tweeted_date: date
	
# 	tweets belongs_to users
