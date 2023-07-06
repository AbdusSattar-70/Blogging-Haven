require 'cancancan'
class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :find_post, only: %i[create new destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.includes(:author).new(author: current_user, **comment_params)
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment added successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end