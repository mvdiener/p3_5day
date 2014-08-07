class Airport < ActiveRecord::Base
  has_many :departing_flights, class_name: "Flight", foreign_key: :departure_airport_id
  has_many :arriving_flights, class_name: "Flight", foreign_key: :arrival_airport_id

  validates :name, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :fs_code, presence: true, uniqueness: true
end
