require 'rails_helper'

RSpec.describe Airport, :type => :model do
 before do
    @airport = Airport.new(name: 'Kansas City International', fs_code: 'MCI',
                           city: 'Kansas City', state: 'MO', country: 'United States')
  end

  subject(:airport) { @airport }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:fs_code) }
  it { is_expected.to respond_to(:city) }
  it { is_expected.to respond_to(:state) }
  it { is_expected.to respond_to(:country) }
  it { is_expected.to respond_to(:departing_flights) }
  it { is_expected.to respond_to(:arriving_flights) }

  it { is_expected.to be_valid }
end
