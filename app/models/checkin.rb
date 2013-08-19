class Checkin < ActiveRecord::Base

	belongs_to :user

	alias_attribute :name, :venue_name

	validates_uniqueness_of :ci_id

	def self.create_from_api(checkin, user_id)

		begin
      new_ci 								= self.new
      new_ci.user_id 				= user_id
      
      new_ci.ci_id 					= checkin.id
      new_ci.created 				= checkin.createdAt
      new_ci.ci_type 				= checkin.type
      new_ci.timezoneoffset = checkin.timeZoneOffset

      new_ci.venue_id 			= checkin.venue.id
      new_ci.venue_name 		= checkin.venue.name

      new_ci.venue_location_address 		= checkin.venue.location.address
      new_ci.venue_location_city 				= checkin.venue.location.city
      new_ci.venue_location_state 			= checkin.venue.location.state
      new_ci.venue_location_crossStreet = checkin.venue.location.crossStreet
      new_ci.venue_location_postalCode 	= checkin.venue.location.postalCode
      new_ci.venue_location_country 		= checkin.venue.location.country
      new_ci.venue_location_cc 					= checkin.venue.location.cc
      new_ci.venue_location_lat 				= checkin.venue.location.lat
      new_ci.venue_location_lng 				= checkin.venue.location.lng

      new_ci.save

    rescue Exception => e
      logger.debug e
    end
	end

  def rounded_lat
    venue_location_lat.to_f.round(3)
  end

  def rounded_lng
    venue_location_lng.to_f.round(3)
  end

end
