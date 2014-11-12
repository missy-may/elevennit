class CategoriesController < ApplicationController

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
    @category = Category.includes(:posts).find params[:id]
  end

  private
    def category_params
      params.require(:category).permit(:name, :title, :description, :sidebar, :submission_text)
    end

    def find_post
      @post = Post.find params[:id]
    end
end
