require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:username) {'exampleuser'}
  subject(:user) { User.new(username: username, email: "user@example.com", password: 'password', password_confirmation: 'password') }

  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to be_valid }

  describe "when name is not present" do
    let(:username) { ' ' }
    it { is_expected.to_not be_valid }
  end
end
