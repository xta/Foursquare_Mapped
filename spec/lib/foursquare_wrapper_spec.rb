require 'spec_helper'

describe "Foursquare Wrapper" do

	it 'accepts a Foursquare token' do
    expect { Api::Foursquare.new("token_goes_here") }.not_to raise_error
	end

end
