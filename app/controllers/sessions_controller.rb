class SessionsController < ApplicationController
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			redirect_to posts_path
		else
			redirect_to posts_path
		end
	end
end
