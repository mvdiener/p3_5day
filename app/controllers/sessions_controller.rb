class SessionsController < ApplicationController
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			redirect_to posts_path
		else
			redirect_to root_path
		end
	end

	def destroy
		session.clear
		redirect_to root_path
	end

	private


end
