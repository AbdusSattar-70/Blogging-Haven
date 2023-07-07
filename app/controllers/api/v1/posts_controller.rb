class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    user = User.find(params[:user_id])
    posts = user.posts

    if posts.present?
      render json: { status: 'Success', message: 'Posts loaded successfully', data: posts }, status: :ok
    else
      render json: { status: 'Not Found', message: 'Opps! might be missing something' }, status: :unprocessable_entity
    end
  end
end
