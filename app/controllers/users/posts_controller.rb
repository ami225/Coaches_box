class Users::PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find(params[:id])
    @coach = @post.coach
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
  end
end
