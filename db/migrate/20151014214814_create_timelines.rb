class CreateTimelines < ActiveRecord::Migration
  def change
  	create_table :timelines do |t|
  		t.integer :user_id
  		t.integer :tweet_id
  	end
  end
end


# table timelines
# 	id: integer primary_key
# 	user_id: integer foreign_key
# 	tweet_id: integer foreign_key
	
# 	timelines belongs_to users
# 	timelines has_many tweets
	
