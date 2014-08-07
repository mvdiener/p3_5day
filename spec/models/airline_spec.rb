require 'rails_helper'

RSpec.describe Airline, :type => :model do
  before do
  	@airline = Airline.new(name: 'examplename')
  end

  subject(:airline) { @airline }

  it { is_expected.to respond_to(:name) }

  describe "when name is not present" do
  	before {@airline.name = ''}
  	it { is_expected.to_not be_valid}
  end
end
