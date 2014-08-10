class Flight < ActiveRecord::Base
	FLIGHT_QUERY_URL_START = "https://api.flightstats.com/flex/flightstatus/rest/v2/json/route/status"
	CREDENTIALS = "?appId=#{ENV['FS_ID']}&appKey=#{ENV['FS_KEY']}"
	FLIGHT_QUERY_URL_END = "&hourOfDay=0&numHours=24&utc=false"

	# before_create :check_time
	belongs_to :airline
	belongs_to :departure_airport, class_name: 'Airport'
	belongs_to :arrival_airport, class_name: 'Airport'
	has_many :posts

	validates :airline, presence: true
	validates :departure_scheduled, presence: true
	validates :departure_actual, presence: true
	validates :arrival_scheduled, presence: true
	validates :arrival_actual, presence: true
	validates :departure_airport, presence: true
	validates :arrival_airport, presence: true

	validate :depart_cant_be_arrival

	def depart_cant_be_arrival
		if arrival_airport == departure_airport
			errors.add(:arrival_airport, "can't be in same city as departure airport")
		end
	end

	def time_to_s(time)
		time.strftime("%I:%M %p")
	end

	def difference_to_s(time)
		on_time = time < 0 ? 'Early by ' : 'Delayed by '
		hours = (time.abs / 3600).to_i
		minutes = ((time.abs/60) - (hours * 60)).to_i
		on_time + "#{hours} hour(s) and #{minutes} minute(s)"
	end

	def satisfied_percent
		total = self.posts.count
		satisfied = self.posts.select{|post| post.satisfied}
		(satisfied.length/total.to_f * 100).to_i
	end

	def arrival_difference
		difference_to_s(self.arrival_actual - self.arrival_scheduled)
	end

	def departure_difference
		difference_to_s(self.departure_actual - self.departure_scheduled)
	end

	def self.api_query(args)
	  url = FLIGHT_QUERY_URL_START + "/#{args[:departing]}/#{args[:arriving]}/arr/#{args[:year]}/#{args[:month]}/#{args[:day]}" + CREDENTIALS + FLIGHT_QUERY_URL_END
	  resp = Net::HTTP.get_response(URI.parse(url))
	  data = resp.body
	  result = JSON.parse(data)
	  if result.has_key? 'Error'
	     raise "web service error"
	  end
	  return result
	end

	def self.parse_flights(api_result)

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
				new_flight.flight_number = flight['flightNumber']
				new_flight.save
			end
			selectable_flights << new_flight
		end
		return selectable_flights
	end

end
