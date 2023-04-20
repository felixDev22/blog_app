# This migration adds a foreign key constraint and an index to the 'posts' table.
class AddForeignKeyToPosts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :posts, :users, column: :author_id
    add_index :posts, :author_id
  end
end
