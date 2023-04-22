class PostsController < ApplicationController
  def index
    @id = params[:user_id]
    @user = current_user
    @posts = Post.where(author_id: @user.id).paginate(page: params[:page], per_page: 2)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post_comments = @post.comments.includes(:author)
    @new_comment = Comment.new
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

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def destroy
    puts 'Destroying comment...'
    @post = current_user.posts.find_by(id: params[:id])
    if @post&.destroy
      flash[:success] = 'Post deleted!'
      current_user.decrement!(:posts_counter) # Decrease the post count by 1 for the current_user
    else
      flash[:danger] = 'Post not deleted!'
    end
    redirect_to user_posts_path(current_user) # Redirect to the user's posts page
  end
end
