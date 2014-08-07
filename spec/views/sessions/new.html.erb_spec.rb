require 'rails_helper'

# RSpec.describe "sessions/new.html.erb", :type => :view do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe "New pages" do

	subject { page }

	describe "signup page" do
		before { visit posts_path }

		it { should have_content('Sign up')}
		it { should have_content('Log in')}
	end

end
