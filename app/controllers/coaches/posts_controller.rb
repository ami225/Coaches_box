class Coaches::PostsController < ApplicationController
    
    def new
      @post = Post.new
    end
    
    def create
      @post = Post.new(post_params)
    if @post.save
      redirect_to coaches_post_path(@post.id)
    else
      render :new
    end
      
      
    end
    
    def show
      @post = Post.find(params[:id])
    end
    
    def index
      @posts = Post.all
    end
    
    def edit
      @post = Post.find(params[:id])
    end
    
    def update
    end
    
    def destroy
    end
    
    private
    def post_params
      params.require(:post).permit(:title, :body, :post, :category_ids)
    end
    
    
end
