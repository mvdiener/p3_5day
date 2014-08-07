require 'spec_helper'

describe "Post pages" do

	subject { page }

	describe "signup page" do
		before { visit posts_path }

		it { should have_content('Sign up')}
		it { should have_content('Log in')}
	end

end
