class AddIndexes < ActiveRecord::Migration
    def change
        add_index :users, :id
        add_index :users, :name
        add_index :tweets, :user_id
        add_index :tweets, :tweeted_at
        add_index :follows, :user_id
        add_index :follows, :followed_user_id
    end
end