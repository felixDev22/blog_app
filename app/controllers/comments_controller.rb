class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    if @comment.save
      flash[:success] = 'Comment created successfully'
    else
      flash[:danger] = "Couldn't create comment"
    end
    redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}"
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
