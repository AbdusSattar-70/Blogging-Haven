class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    if params[:id] == 'sign_out'
      sign_out(current_user)
      redirect_to root_path, notice: 'Signed out successfully.'
    else
      @user = User.find(params[:id])
      @recent_posts = @user.recent_posts
      @recent_posts.each do |post|
        @post = post
      end
    end
  end
end
