class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author: current_user)
    if @like.save
      redirect_to user_post_like_path(current_user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
