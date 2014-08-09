class Flight < ActiveRecord::Base
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

end
