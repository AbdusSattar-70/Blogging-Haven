class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end

  def show
    user = User.find(params[:user_id])
    user.posts.each do |post|
      @post = post
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post created successfully'
    else
      render :new, alert: 'Failed to create post'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_back(fallback_location: root_path, notice: 'Post Deleted Successfully')
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
