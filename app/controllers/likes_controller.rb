class LikesController < ApplicationController
  def index
    @likes = Like.include(:post)
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(author_id: @user.id, post_id: @post.id)
    return unless @like.save

    redirect_to user_posts_path(@post.id, @post)
  end
end
