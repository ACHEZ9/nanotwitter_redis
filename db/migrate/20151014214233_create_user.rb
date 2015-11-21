class CreateUser < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :name
        t.string :password
  		t.string :email
  		t.date :created_at
  		t.date :last_login
  	end
  end
end

# table users
# 	id: integer primary_key
# 	email: string
# 	name: string
# 	password: string
# 	bio: string
# 	created_at: date
# 	last_log_in: date

# 	users has_many follows 
# 	users has_many followers through follows
# 	users has_many tweets
