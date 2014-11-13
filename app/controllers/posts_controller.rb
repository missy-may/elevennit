class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :new, :update, :create, :destroy]

  def index
    @posts = Post.with_categories.page(params[:page])
  end

  def show
  end

  def edit
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, flash: { notice: 'Your post has been removed.' }
    else
      redirect_to posts_path, flash: { notice: 'We were unable to remove that post.' }
    end
  end

  def new
    @post = Post.new
    @post.post_type = params[:post_type] if params[:post_type].present?
  end

  def update
    if @post.update_attributes post_params
      redirect_to posts_path, flash: { notice: 'Post Updated!' }
    else
      flash.now[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to posts_path, flash: { notice: 'New Post Created!' }
    else
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :link, :body, :post_type, :category_id)
    end

    def find_post
      @post = Post.find params[:id]
    end

end
