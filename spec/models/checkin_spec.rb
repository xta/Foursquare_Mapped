require 'spec_helper'

describe Checkin do
  
  context 'associations' do
		it { should belong_to :user }
	end

end
