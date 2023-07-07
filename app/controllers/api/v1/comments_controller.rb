class Api::V1::CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    post = Post.find(params[:post_id])
    comments = post.comments

    if comments.present?
      render json: { status: 'Success', message: ' Comments are loaded successfully', data: comments }, status: :ok
    else
      render json: { status: 'Not Found', message: 'Opps! might be missing something' }, status: :unprocessable_entity
    end
  end

  def create
    user = User.find(params[:user_id])
    current_post = Post.find(params[:post_id])
    comments = current_post.comments.build(comment_params.merge(author: user))

    if comments.save
      render json: { status: 'Success', message: 'Comment Created Successfully', data: comments }, status: :ok
    else
      render json: { status: 'Not Found', message: 'Opps! might be missing something', data: comments.errors },
             status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
