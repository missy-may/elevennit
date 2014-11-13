class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new, :update, :create, :destroy]
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to posts_path, flash: { notice: 'New Category Created!' }
    else
      flash.now[:error] = @category.errors.full_messages
      render :new
    end
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.includes(posts: [:comment_threads]).find(params[:id])
    @posts = @category.posts.page(params[:page])
  end

  private
    def category_params
      params.require(:category).permit(:name, :title, :description, :sidebar, :submission_text)
    end

    def find_post
      @post = Post.find params[:id]
    end
end
