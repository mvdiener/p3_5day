require 'json'
require 'net/http'
require 'date'

class FlightsController < ApplicationController

	respond_to :json

	def create
		split_date = params[:date].split("-")
		date_hash = {year: split_date[0], month: split_date[1], day: split_date[2]}
		result = Flight.api_query(params.merge(date_hash))
		@post = Post.new
		@flights = Flight.parse_flights(result)
		@flights.map!{|flight| create_option(flight)}
		@flights.sort!
		render 'posts/_create_post_form', layout: false
	end

	def show
		@flight = Flight.find(params[:id])
		@posts = @flight.posts.all.reverse
	end

	private

		def create_option(flight)
			["#{flight.airline.name} Flight #{flight.flight_number} (Arrived #{time_to_s(flight.arrival_actual)})", flight.id]
		end

		def time_to_s(time)
			time.strftime("%I:%M %p")
		end

end

