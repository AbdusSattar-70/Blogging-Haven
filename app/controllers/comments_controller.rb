class CommentsController < ApplicationController
  before_action :find_post, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params.merge(author: current_user))

    respond_to do |format|
      if @comment.save
        format.html do
          redirect_to user_post_path(@post.author, @post), flash: { success: 'Comment added successfully' }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
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
