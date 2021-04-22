class Coaches::PostsController < ApplicationController
  before_action :authenticate_coach!
  before_action :ensure_correct_coach, only: [:edit, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.coach_id = current_coach.id
    if @post.save
      flash[:notice] = "アドバイスを投稿しました！"
      redirect_to coaches_post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @coach = @post.coach
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to coaches_post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to coaches_coach_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post)
  end

  # ログインコーチのみ表示できる
  def ensure_correct_coach
    @post = Post.find_by(id: params[:id])
    unless @post.coach == current_coach
      flash[:notice] = "権限がありません"
      redirect_to coaches_posts_path
    end
  end
end
