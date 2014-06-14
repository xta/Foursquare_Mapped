require 'spec_helper'

describe User do

	context 'associations' do
    it "has many checkins" do
      u = User.new
      expect { u.checkins }.not_to raise_error
    end
	end

end
