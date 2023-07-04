class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author_id: current_user.id)
    if @like.save
      redirect_to user_post_likes_path(current_user, @post)
    else
      redirect_to user_post_path(current_user, @post), alert: 'Failed to create like.'
    end
  end
end
