class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    if @post = Post.create(post_params)
      flash[:success] = "Your Instabum post has been created!"
      redirect_to root_path
    else
      flash.now[:alert] = "Your Instabum post could not be created. Please check that you have entered all the necessary criteria"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Your Instabum post has been updated!"
      redirect_to root_path
    else
      flash.now[:alert] = "Your Instabum post could not be updated. Please check that you have entered all the necessary criteria"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Your Instabum post has been deleted!"
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
