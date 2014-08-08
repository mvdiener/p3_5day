require 'json'
require 'net/http'

class FlightApiController < ApplicationController

	respond_to :json

	FLIGHT_QUERY_URL_START = "https://api.flightstats.com/flex/flightstatus/rest/v2/json/route/status"
	CREDENTIALS = "?appId=#{ENV['FS_ID']}&appKey=#{ENV['FS_KEY']}"
	FLIGHT_QUERY_URL_END = "&hourOfDay=0&numHours=24&utc=false&maxFlights=10"

	def create
		respond_to do |format|
			split_date = params[:date].split("-")
			date_hash = {year: split_date[0], month: split_date[1], day: split_date[2]}
			result = flight_query(params.merge(date_hash))
			format.json {render json: parse_flights(result)}
		end
	end

	private

		def parse_flights(api_result)

			landed_flights = api_result['flightStatuses'].select do |flight|
				flight['operationalTimes']['actualGateArrival']
			end

			selectable_flights = []

			landed_flights.each do |flight|
				flight = Flight.new

				flight.departure_airport = Airport.find_by(fs_code: flight['departureAirportFsCode'])
				flight.arrival_ariport = Airport.find_by(fs_code: flight['arrivalAirportFsCode'])
				flight.airline = Airline.find_by(fs_code: flight['carrierFsCode'])

				flight.arrival_scheduled = flight['operationalTimes']['scheduledGateArrival']['dateLocal'],
				flight.arrival_actual = flight['operationalTimes']['actualGateArrival']['dateLocal'],
				flight.departure_scheduled = flight['operationalTimes']['scheduledGateDeparture']['dateLocal'],
				flight.departure_actual = flight['operationalTimes']['actualGateDeparture']['dateLocal']
				flight.fs_code = flight['flightId'].to_i

				flight.save
				selectable_flights << flight
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

end
