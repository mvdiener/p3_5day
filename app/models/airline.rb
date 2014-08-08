class Airline < ActiveRecord::Base
  validates :name, presence: :true
  has_many :flights
end
