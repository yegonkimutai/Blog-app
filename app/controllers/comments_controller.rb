class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(@post.id, @post)
    else
      # Handle errors if the comment cannot be saved
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
