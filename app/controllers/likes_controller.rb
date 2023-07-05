class LikesController < ApplicationController
  def create
    @post = Post.includes(:author).find(params[:post_id])
    @like = @post.likes.new(author_id: @post.author.id)
    if @like.save
      redirect_to user_post_likes_path(@post.author, @post)
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Failed to create like.'
    end
  end
end
