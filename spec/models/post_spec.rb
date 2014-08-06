require 'rails_helper'

RSpec.describe Post, :type => :model do
  before do
    @post = Post.new(satisfied: true, text: 'Great flight! #milehighclub',
                     user_id: 1, flight_id: 1)
  end

  subject(:post){ @post }

  it { is_expected.to respond_to(:flight_id) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:satisfied) }
  it { is_expected.to respond_to(:text) }

  it { is_expected.to be_valid }

  describe "when flight_id is not present" do
    before {@post.flight_id = ''}
    it { is_expected.to_not be_valid }
  end

  describe "when user_id is not present" do
    before {@post.user_id = ''}
    it { is_expected.to_not be_valid }
  end

  describe "when text is not present" do
    before {@post.text = ''}
    it { is_expected.to_not be_valid }
  end

  describe "when satisfied is not present" do
    before {@post.satisfied = ''}
    it { is_expected.to_not be_valid }
  end

  describe "when text is too long" do
    before { @post.text = Faker::Lorem.characters(141) }
    it { is_expected.to_not be_valid }
  end

end
