require 'foursquare2'

module Api
    class Foursquare

        attr_accessor :client, :all_checkins

        def initialize(token, user_id = nil)
            @client = Foursquare2::Client.new(:oauth_token => token)
            @all_checkins = user_id ? User.find(user_id).checkins.order("created ASC").to_a : []
            @user_id = user_id
        end

        def latest_checkin
            user_checkins(:limit => 1).first
        end

        def load_all_checkins
            @all_checkins.concat( user_checkins(:limit => 250, :sort => "newestfirst") )

            complete = false

            while !complete
                oldest_checkin = @all_checkins.last
                oldest_created = oldest_checkin.respond_to?(:createdAt) ? oldest_checkin.createdAt : oldest_checkin.created

                older_checkins = user_checkins(:limit => 250, :sort => "newestfirst", beforeTimestamp: oldest_created)
                @all_checkins.concat( older_checkins )

                older_count = older_checkins.count
                complete = true if older_count <= 0
            end

            @all_checkins.reverse
        end

        def load_any_new_checkins
            newest_known = @all_checkins.last
            newest_created = newest_known.created

            complete = false
            new_recorded_ids = {}

            while !complete
                newer_checkins = user_checkins(:limit => 250, :sort => "newestfirst", afterTimestamp: newest_created)
                any_new_ones = false

                newer_checkins.each do |ci|
                    checkin_is_new = Checkin.where(user_id: @user_id, ci_id: ci.ci_id).empty?
                    checkin_is_known = new_recorded_ids[ci.id]

                    next if checkin_is_known
                    any_new_ones = true if checkin_is_new

                    new_recorded_ids[ci.id] = true
                    @all_checkins.push(ci)
                end

                if !any_new_ones
                    complete = true
                else
                    newest_created = newer_checkins.first.createdAt
                end
            end

            @all_checkins
        end

        private

            def user_checkins(options={})
                options.merge!(v: 20140614)
                @client.user_checkins(options).items
            end

  end
end
