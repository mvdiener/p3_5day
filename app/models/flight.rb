class Flight < ActiveRecord::Base
	# before_create :check_time
	belongs_to :airline
	has_many :posts

	validates :airline, :departure_scheduled, :departure_actual, :arrival_scheduled, :arrival_actual, :departure_city, :arrival_city, presence: true

	validate :depart_cant_be_arrival, :time_constraints

	def depart_cant_be_arrival
		if arrival_city == departure_city
			errors.add(:wrong_departure, "can't be in same city")
		end
	end

	def time_constraints
		if (arrival_actual <= departure_actual)
			errors.add(:bad_time, "arrival can't be earlier than departure")
		end
	end


end
