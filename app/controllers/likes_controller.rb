class LikesController < ApplicationController
  def create
    @user = current_user
    @like = Like.new(author: @user, post: @post)
    @like.save
    if like.save!
      flash[:success] = 'like added'
    else
      flash[:error] = 'like was not added'
    end
    redirect_to user_post_path(@user, @post)
  end
end
