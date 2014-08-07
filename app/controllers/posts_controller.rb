class PostsController < ApplicationController
	def index
	end

  def create
    @post = Post.create(post_params)
  end

  def destroy
  end

  def home
    @post = Post.new
  end

  private

  def post_params
    params.require(:post).permit(:text, :satisfied, flight: Flight.new)
  end

end
