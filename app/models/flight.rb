class Flight < ActiveRecord::Base
  validates :airline, presence: :true
  validates :departure_scheduled, presence: :true
  validates :departure_actual, presence: :true
  validates :arrival_actual, presence: :true
  validates :arrival_scheduled, presence: :true
  validates :departure_airport, presence: :true
  validates :arrival_airport, presence: :true
  validate :airport_locations

def airport_locations
  errors.add(:departure_airport, "can't be the same as arrival airport") if departure_airport == arrival_airport
end
  has_many :posts
  belongs_to :airline
  belongs_to :arrival_airport, class_name: Airport
  belongs_to :departure_airport, class_name: Airport
end
