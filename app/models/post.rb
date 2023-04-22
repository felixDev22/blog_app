# This class represents a post created by a user.
# Posts can have many comments and likes.
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id, dependent: :destroy
  has_many :comments, foreign_key: :post_id, dependent: :destroy


  after_create :update_posts_counter
  after_destroy :update_posts_counter

  def initialize(attributes = {})
    super
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_posts_counter
    author.update(posts_counter: author.posts_counter + 1)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
