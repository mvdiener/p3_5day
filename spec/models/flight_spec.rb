require 'rails_helper'
require 'active_support/core_ext/date_time/calculations'
# require 'active_support/all'

RSpec.describe Flight, :type => :model do
  before do 
  	@time = Time.now
  	@flight = Flight.new(departure_scheduled: @time, departure_actual: (@time + (2 *60 * 60)) ,arrival_scheduled: (@time + (2 *60 * 60)),  arrival_actual: (@time + (4 *60 * 60)), departure_city: "Chicago", arrival_city: "New York")
    @flight.airline = Airline.new
  end

  subject(:flight) { @flight }

	it { is_expected.to respond_to(:airline) }
  it { is_expected.to respond_to(:departure_scheduled) }
  it { is_expected.to respond_to(:departure_actual) }
  it { is_expected.to respond_to(:arrival_scheduled) }
  it { is_expected.to respond_to(:arrival_actual) }
  it { is_expected.to respond_to(:departure_city) }
  it { is_expected.to respond_to(:arrival_city) }

  

  describe "when airline_id is not present" do
  	before {@flight.airline = nil}
  	it { is_expected.to_not be_valid }
  end

  describe "when departure_scheduled is not present" do
  	before {@flight.departure_scheduled = ''}
  	it { is_expected.to_not be_valid }
  end

  describe "when departure_actual is not present" do
  	before {@flight.departure_actual = ''}
  	it { is_expected.to_not be_valid }
    
  end

  describe "when arrival_scheduled is not present" do
  	before {@flight.arrival_scheduled = '' }
  	it { is_expected.to_not be_valid }
  end

  describe "when arrival_actual is not present" do
  	before {@flight.arrival_actual = ''}
  	it { is_expected.to_not be_valid }
    
  end

  describe "when departure_city is not present" do
  	before {@flight.departure_city = ''}
  	it { is_expected.to_not be_valid }
  end

  describe "when arrival_city is not present" do
  	before {@flight.arrival_city = ''}
  	it { is_expected.to_not be_valid }
  end

  describe "arrival actual cannot be earlier than departure actual" do
    before do 
      @flight.departure_actual = Time.now
      @flight.arrival_actual = Time.now - 1000
    end
    it { is_expected.to_not be_valid }
  end

  describe "departure city cannot be the same as arrival city" do
    before do
      @flight.departure_city = "hooray"
      @flight.arrival_city  = "hooray"
    end
    it { is_expected.to_not be_valid}
  end


end
