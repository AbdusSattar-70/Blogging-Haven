class PostsController < ApplicationController
  before_action :set_user, only: %i[index new show create]

  def index
    @posts = @user.posts
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path, notice: 'Post Created Successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
