require 'json'
require 'net/http'

class FlightApiController < ApplicationController

	FLIGHT_QUERY_URL_START = "https://api.flightstats.com/flex/flightstatus/rest/v2/json/route/status"
	CREDENTIALS = "?appId=#{ENV['FS_ID']}&appKey=#{ENV['FS_KEY']}"
	FLIGHT_QUERY_URL_END = "&hourOfDay=0&numHours=24&utc=false&maxFlights=10"

	def create
		split_date = params[:date].split("-")
		date_hash = {year: split_date[0], month: split_date[1], day: split_date[2]}
		result = flight_query(params.merge(date_hash))
		puts result
	end

	private

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
