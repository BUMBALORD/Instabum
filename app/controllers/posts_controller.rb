class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def new
    @post = current_user.posts.build
  end

  def show
  end

  def create
      @post = current_user.posts.build(post_params)
      if @post.save
        flash[:success] = "Your Instabum post has been created!"
        redirect_to posts_path
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

  def owned_post
  unless current_user == @post.user
    flash[:alert] = "That post doesn't belong to you!"
    redirect_to root_path
  end
end

end
