# This migration creates a 'Comments' table with a foreign key reference to the 'users' and 'posts' tables.
class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :text

      t.timestamps
    end
  end
end
