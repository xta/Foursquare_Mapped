require 'foursquare2'

module Api
	class Foursquare

		attr_accessor :client, :all_checkins

		def initialize(token)
			@client = Foursquare2::Client.new(:oauth_token => token)
			@all_checkins = []
		end

		def first_checkin
	    user_checkins(:limit => 1, :sort => 'oldestfirst').first
	  end

	  def latest_checkin
	    user_checkins(:limit => 1, :sort => 'newestfirst').first
	  end

	  def load_all_checkins
	    @all_checkins.concat( user_checkins(:limit => 250, :sort => "oldestfirst") )
	    load_any_new_checkins
	  end

	  def load_any_new_checkins
	    latest_ci_id = latest_checkin.id

	    until @all_checkins.detect { |ci| ci.id == latest_ci_id }
	      additional_checkins = user_checkins( :limit => 250, :sort => "oldestfirst", :afterTimestamp => @all_checkins.last.createdAt )
	      additional_checkins.each { |c| @all_checkins.push(c) unless @all_checkins.include?(c) }
	    end

	    return @all_checkins
	  end

		private

		  def user_checkins(options={})
		  	options.merge!(v: 20140614)
		    @client.user_checkins(options).items
		  end

  end
end
