class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      flash[:notice] = 'Comment added successfully!'
      @comment.update_comments_counter
      redirect_to user_post_path(current_user.id, @post.id)
    else
      flash[:alert] = "Couldn't create Comment!"
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])

    if @comment&.destroy
      flash[:success] = 'Comment deleted!'
      @comment.post.decrement!(:comments_counter)
    else
      flash[:danger] = 'Comment not deleted!'
    end
    redirect_to user_post_path(current_user.id, @post.id)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
