module PagesHelper

	def checkin_details
		"#{@checkin.venue_name} (#{@checkin.venue_location_state})"
	end

  def checkin_date(checkin)
    Time.at(checkin.created).to_date
  end

end
