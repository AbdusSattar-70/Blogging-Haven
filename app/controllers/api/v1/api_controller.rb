class Api::V1::PostsController < ApplicationController
   def index
    user = User.find(params[:user_id])
    posts = user.posts
    if posts
      render json: { status: 'Success', message: 'Loaded Posts', data: posts }, status: :ok
    else
      render json: { status: 'Not Found', message: 'Posts not found', data: posts.errors },
             status: :unprocessable_entity
    end
  end
end