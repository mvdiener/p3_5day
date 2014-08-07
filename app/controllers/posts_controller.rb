class PostsController < ApplicationController
	def index
	end

  def create
    @post = Post.new(post_params)
  end

  def destroy
  end

  def home
  end

  private

  def post_params
    params.require(:post).permit(:text, :satisfied)
  end

end
