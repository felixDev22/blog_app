class CommentsController < ApplicationController
  
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      flash[:notice] = 'Comment added successfully!'
      @comment.update_comments_counter
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
    else
      flash[:alert] = "Couldn't create Comment!"
      render :new, status: :unprocessable_entity
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
    redirect_to "/users/#{current_user.id}"
  end

  def comment_params
  params.require(:comment).permit(:text)
end
end
