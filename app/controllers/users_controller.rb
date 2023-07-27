class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(posts: %i[comments likes]).find(params[:id])
  end

  private
  def set_user
    @user = User.find(params[:id])
    render file: "#{Rails.root}/public/404.html", status: :not_found unless @user
  end
end
