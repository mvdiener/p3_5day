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
end
