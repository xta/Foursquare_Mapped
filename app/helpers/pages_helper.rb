module PagesHelper

	def checkin_details
		"#{@checkin.venue_name} (#{@checkin.venue_location_state})"
	end

end
