class AirlinesController < ApplicationController

	def show
		@airline = Airline.find(params[:id])
	end

end
