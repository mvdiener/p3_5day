class UsersController < ApplicationController
	def index
		current_user
		@users = User.all
	end

	def new
		if current_user
			redirect_to(root_path)
		else
			@user = User.new
			render 'new'
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:current_user_id] = @user.id
			redirect_to root_path
		else
			render 'new'
		end
	end

<<<<<<< HEAD
	def posts
		@posts = Post.find_by(@user.id)
=======
	def show
		user = User.find(current_user.id)
		@posts = user.posts.reverse
>>>>>>> 9f3df0a41a7c409257fa321fe45481a36dd9e6b5
	end

	private

	   def user_params
     	params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end
end
