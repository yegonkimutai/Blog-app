class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @comment = Comment.new
    json_response(@comment)
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:post_id])
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
    json_response(@comments)
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

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to user_post_path(@post.id, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
