# This migration adds a foreign key constraint and an index to the 'comments' table.
class AddForeignKeyToComments < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :comments, :users, column: :user_id
    add_index :comments, :user_id
  end
end
