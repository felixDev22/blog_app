# This class represents a comment on a post.
# Comments belong to a post and are written by a user.
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'
  validates :author, presence: true

  after_save :update_comments_counter

  def recent_comments
    comments.order('created_at Des').limit(5)
  end

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
