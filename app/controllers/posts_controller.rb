class PostsController < ApplicationController
	def index
    @posts = Post.all
	end

  def create
    @post = Post.new(post_params)
    @post.flight = Flight.new
    @post.user = current_user
    @post.save
    redirect_to posts_path
  end

  def destroy
  end

  def home
    @post = Post.new
  end

  private

  def post_params
    params.require(:post).permit(:text, :satisfied)
  end

end
