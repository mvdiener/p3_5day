class Flight < ActiveRecord::Base
	# before_create :check_time
	belongs_to :airline
	belongs_to :departure_airport, class_name: 'Airport'
	belongs_to :arrival_airport, class_name: 'Airport'
	has_many :posts

	validates :airline, :departure_scheduled, :departure_actual, :arrival_scheduled, :arrival_actual, :departure_airport, :arrival_airport, presence: true

	validate :depart_cant_be_arrival

	def depart_cant_be_arrival
		if arrival_airport == departure_airport
			errors.add(:arrival_airport, "can't be in same city as departure airport")
		end
	end

end
