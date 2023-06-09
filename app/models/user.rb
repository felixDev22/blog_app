# app/models/user.rb
# This class represents a user who can create posts, comments, and likes.
# Users have a name and a counter for their posts.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  attribute :posts_counter, :integer, default: 0
  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  ROLES = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end
end
