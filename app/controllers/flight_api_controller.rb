require 'json'
require 'net/http'
require 'date'

class FlightApiController < ApplicationController

	respond_to :json

	FLIGHT_QUERY_URL_START = "https://api.flightstats.com/flex/flightstatus/rest/v2/json/route/status"
	CREDENTIALS = "?appId=#{ENV['FS_ID']}&appKey=#{ENV['FS_KEY']}"
	FLIGHT_QUERY_URL_END = "&hourOfDay=0&numHours=24&utc=false&maxFlights=10"

	def create
		split_date = params[:date].split("-")
		date_hash = {year: split_date[0], month: split_date[1], day: split_date[2]}
		result = flight_query(params.merge(date_hash))
		@post = Post.new
		@flights = parse_flights(result)
		@flights.map!{|flight| create_option(flight)}
		render 'posts/_create_post_form', layout: false
	end

	private

		def parse_flights(api_result)

			landed_flights = api_result['flightStatuses'].select do |flight|
				flight['operationalTimes']['actualGateArrival']
			end

			selectable_flights = []

			landed_flights.each do |flight|
				new_flight = Flight.find_by(fs_code: flight['flightId'])
				unless new_flight
					new_flight = Flight.new

					new_flight.departure_airport = Airport.find_by(fs_code: flight['departureAirportFsCode'])
					new_flight.arrival_airport = Airport.find_by(fs_code: flight['arrivalAirportFsCode'])
					new_flight.airline = Airline.find_by(fs_code: flight['carrierFsCode'])

					new_flight.arrival_scheduled = flight['operationalTimes']['scheduledGateArrival']['dateLocal']
					new_flight.arrival_actual = flight['operationalTimes']['actualGateArrival']['dateLocal']
					new_flight.departure_scheduled = flight['operationalTimes']['scheduledGateDeparture']['dateLocal']
					new_flight.departure_actual = flight['operationalTimes']['actualGateDeparture']['dateLocal']
					new_flight.fs_code = flight['flightId']
					new_flight.save
				end
				selectable_flights << new_flight
			end
			return selectable_flights
		end

		def flight_query(args)
		  url = FLIGHT_QUERY_URL_START + "/#{args[:departing]}/#{args[:arriving]}/arr/#{args[:year]}/#{args[:month]}/#{args[:day]}" + CREDENTIALS + FLIGHT_QUERY_URL_END
		  resp = Net::HTTP.get_response(URI.parse(url))
		  data = resp.body
		  result = JSON.parse(data)
		  if result.has_key? 'Error'
		     raise "web service error"
		  end
		  return result
		end

		def create_option(flight)
			["Departed #{flight.departure_airport.fs_code} at #{time_to_s(flight.departure_actual)} - Arrived #{flight.arrival_airport.fs_code} at #{time_to_s(flight.arrival_actual)}", flight.id]
		end

		def time_to_s(time)
			time.strftime("%I:%M %p")
		end

end
