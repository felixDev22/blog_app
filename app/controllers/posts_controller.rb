class PostsController < ApplicationController
  def index
    @id = params[:user_id]
    @user = User.find(@id)
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @post = Post.find_by(id: params[:id])

    @post_comments = @post.comments.includes(:author)
    @new_comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
    render :new, locals: { post: @post }
  end

  def create
    @user = current_user
    @post = Post.new(
      author: @user,
      title: params[:post][:title],
      text: params[:post][:text],
      comments_counter: 0,
      likes_counter: 0
    )
    if @post.save
      flash[:success] = 'Post saved successfully.'
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = 'Sorry something went wrong'
      render :new
    end
  end
end
