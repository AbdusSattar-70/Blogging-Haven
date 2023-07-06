class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author_id: current_user.id)

    if @like.save
      redirect_back(fallback_location: root_path, notice: 'Liked')
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to create like.')
    end
  end
end
