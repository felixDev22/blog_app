# This migration creates a 'likes' table with a foreign key reference to the 'users' and 'posts' tables.
class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
