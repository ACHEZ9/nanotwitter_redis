class CreateFollow < ActiveRecord::Migration
  def change
  	create_table :follows do |t|
  		t.integer :user_id
  		t.integer :followed_user_id
  	end
  end
end


# table follows
# 	id: integer primary_key
# 	user_id: integer
# 	followed_user_id: integer

# 	follows belongs_to users
# 	follows belongs_to followers, class_name: ‘User’
# 	foreign keys user_id, followed_user_id

