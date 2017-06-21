class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all 
  end
  
  def new
    if params[:back]
      @post = Post.new(posts_params)
    else
      @post = Post.new
    end
  end
  
  def create
    @post = Post.new(posts_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "写真を投稿しました！"
    else
      render 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(posts_params)
      redirect_to posts_path, notice: "更新しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "削除しました！"
  end
  
  def confirm
    @post = Post.new(posts_params)
    render :new if @post.invalid?
  end
  
  private
    def posts_params
      params.require(:post).permit(:title, :content)
    end
    
    def set_post
      @post = Post.find(params[:id])
    end
end
