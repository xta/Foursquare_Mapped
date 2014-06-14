require 'spec_helper'

describe Checkin do

  context 'associations' do
    it "belongs to user" do
      c = Checkin.new
      expect { c.user }.not_to raise_error
    end
	end

end
