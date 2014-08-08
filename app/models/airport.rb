class Airport < ActiveRecord::Base
  has_many :departing_flights
  has_many :arriving_flights
end
