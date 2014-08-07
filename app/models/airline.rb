class Airline < ActiveRecord::Base
	has_many :flights

	validates :name, presence: true
end
