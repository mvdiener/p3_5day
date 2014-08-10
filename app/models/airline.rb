class Airline < ActiveRecord::Base
	has_many :flights

	validates :name, presence: true

	def satisfied_percent
		posts = []
		self.flights.each {|flight| posts << flight.posts }
		total = posts.flatten.count
		satisfied = posts.select{|post| post.satisfied}
		satisfied.length/total.to_f * 100
	end

	def parse_flights
		self.flights.map do |flight|
			{
				"flight" => flight.flight_number,
				"arrivalDifference" => arrival_difference(flight),
				"departureDifference" => departure_difference(flight)
			}
		end
	end

	def difference_to_s(time)
		minutes = (time/60).to_i.to_s
	end

	def arrival_difference(flight)
		difference_to_s(flight.arrival_actual - flight.arrival_scheduled)
	end

	def departure_difference(flight)
		difference_to_s(flight.departure_actual - flight.departure_scheduled)
	end

end
