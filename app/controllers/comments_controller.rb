class CommentsController < ApplicationController
  before_action :find_post, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(author: current_user, **comment_params)
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment added successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
