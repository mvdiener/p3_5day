class AirlinesController < ApplicationController

	def show
		current_user
		@airline = Airline.find(params[:id])
	end

end
