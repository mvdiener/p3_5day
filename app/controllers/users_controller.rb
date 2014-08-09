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

	def show
		current_user
		unless User.exists?(id: params[:id])
			redirect_to root_path
		else 
			@user = User.find(params[:id])
			@posts = @user.posts.reverse
		end
	end

	private

	   def user_params
     	params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end
end
