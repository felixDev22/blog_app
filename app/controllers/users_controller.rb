class UsersController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @users = User.all.order(created_at: :asc).includes(:posts)
    @current_user = current_user
  end

  def show
    @user = User.includes(posts: %i[likes comments]).find(params[:id])
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    @recent_posts = @user.recent_posts
  end
end
