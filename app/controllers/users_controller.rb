class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
   @users = User.find(params[:id])
   @user_posts = Post.where(author_id: @user.id)
   @recent_posts = @user.recent_posts
  end
end
