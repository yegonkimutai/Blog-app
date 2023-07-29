class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    json_response(@posts)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id])
    authorize! :create, @post
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(params[:user_id])
    @post.author = current_user
    authorize! :create, @post

    if @post.save
      redirect_to user_post_url(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize! :edit, @post # Ensure user is allowed to edit this post
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    @post.destroy

    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
