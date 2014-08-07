require 'spec_helper'

describe "Post pages" do

	subject { page }

	pending "signup page" do
		before { visit root_path }

		it { should have_content('Sign up')}
		it { should have_content('Log in')}
	end

end
