class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :link, :body))
    if @post.save
      redirect_to posts_path, flash: { notice: 'It Worked.' }
    else
      flash.now[:error] = 'Whoops! Something went wrong. Please try again.'
      render :new
      # redirect_to new_post_path, flash: { error: 'Whoops! Something went wrong. Please try again.' }
    end
  end

end
