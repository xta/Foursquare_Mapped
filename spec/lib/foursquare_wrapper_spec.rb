require 'spec_helper'

describe "Foursquare Wrapper" do

	# initial basic test
	it 'should be a Foursquare2::Client' do
		Api::Foursquare.new("foobar_token").instance_of?( Foursquare2::Client )
	end

end
