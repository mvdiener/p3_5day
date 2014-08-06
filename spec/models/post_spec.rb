require 'rails_helper'

RSpec.describe Post, :type => :model do
  before do
    @post = Post.new(satisfied: true, text: 'Great flight! #milehighclub')
  end

  subject(:post){ @post }

  it { is_expected.to respond_to(:satisfied) }
  it { is_expected.to respond_to(:text) }

  it { is_expected.to be_valid }

  describe "when text is not present" do
    before {@post.text = ''}
    it { is_expected.to_not be_valid }
  end

  describe "when satisfied is not present" do
    before {@post.satisfied = ''}
    it { is_expected.to_not be_valid }
  end

end
