class AirlinesController < ApplicationController

	def show
		current_user
		@airline = Airline.find(params[:id])
		@flights = @airline.parse_flights
	end

end
