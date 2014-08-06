require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = User.new(username: 'exampleuser', email: "user@example.com", password: 'password', password_confirmation: 'password')
  end

  subject(:user) { @user }

  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to be_valid }

  describe "when name is not present" do
    before {@user.username = ''}
    it { is_expected.to_not be_valid }
  end

  describe "when email is not present" do
    before {@user.email = ''}
    it { is_expected.to_not be_valid }
  end

  describe "when email format is invalid" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      before {@user.email = invalid_address}
      it { is_expected.to_not be_valid }
    end
  end

  describe "when email format is valid" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      before { @user.email = valid_address }
      it { is_expected.to be_valid }
    end
  end
end
