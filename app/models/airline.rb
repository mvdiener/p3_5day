class Airline < ActiveRecord::Base
	has_many :flights
	has_many :posts, through: :flights

	validates :name, presence: true

	def satisfied_percent
		posts = []
		self.flights.each {|flight| posts << flight.posts }
		total = posts.flatten.count
		satisfied = posts.select{|post| post.satisfied}
		satisfied.length/total.to_f * 100
	end

	def parse_flights
		parsed_flights = self.flights.map do |flight|
			{
				"flight" => flight.fs_code.to_s,
				"flight_number" => flight.flight_number,
				"arrivalDifference" => arrival_difference(flight),
				"departureDifference" => departure_difference(flight),
				"arrivalActual" => flight.time_to_s(flight.arrival_actual),
				"departureActual" => flight.time_to_s(flight.departure_actual)
			}
		end
		parsed_flights.to_json
	end

	def difference_to_s(time)
		minutes = (time/60).to_i.to_s
	end

	def arrival_difference(flight)
		difference_to_s(flight.arrival_scheduled - flight.arrival_actual)
	end

	def departure_difference(flight)
		difference_to_s(flight.departure_scheduled - flight.departure_actual)
	end

	def time_to_s(time)
		time.strftime("%I:%M %p")
	end

	def satisfied_percent
		total = self.posts.count
		satisfied = self.posts.select{|post| post.satisfied}
		(satisfied.length/total.to_f * 100).to_i
	end

end
