class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :asc).includes(:posts)
    @current_user = current_user
  end

  def show
    @user = User.includes(posts: %i[likes comments]).find(params[:id])
    @user_posts = Post.where(author_id: @user.id)
    @recent_posts = @user.recent_posts
  end
end
