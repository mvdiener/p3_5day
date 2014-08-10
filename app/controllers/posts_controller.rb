class PostsController < ApplicationController
	def index
    current_user
    @posts = Post.all.reverse
	end

  def create
    @post = Post.new(post_params)
    @post.flight = Flight.find(params[:post][:flight])
    @post.user = current_user
    @post.save
    redirect_to posts_path
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:text, :satisfied)
  end

end
