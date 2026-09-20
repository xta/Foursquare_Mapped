require 'faraday'
require 'hashie'
require 'json'

# Replacement for the abandoned `foursquare2` gem (last released 2014, pins
# faraday 0.x). Talks to the Foursquare v2 REST API directly over faraday and
# returns Hashie::Mash objects, so every caller below -- and Checkin
# .create_from_api -- keeps working unchanged.
module Api
    class Foursquare

        API_ROOT    = 'https://api.foursquare.com'.freeze
        API_VERSION = '20140614'.freeze

        # Mash that does not log warnings for keys that collide with built-in
        # method names (checkin JSON contains "id", "type", "count", ...).
        class Response < ::Hashie::Mash
            disable_warnings
        end

        class ApiError < StandardError; end

        attr_accessor :client, :all_checkins

        def initialize(token, user_id = nil)
            @token = token
            @client = build_client
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

            def build_client
                Faraday.new(url: API_ROOT) do |conn|
                    conn.options.timeout      = 30
                    conn.options.open_timeout = 10
                    conn.adapter Faraday.default_adapter
                end
            end

            def user_checkins(options={})
                options.merge!(v: API_VERSION)
                get('/v2/users/self/checkins', options).dig('response', 'checkins', 'items').to_a.map { |item| Response.new(item) }
            end

            def get(path, params)
                response = @client.get(path, params.merge(oauth_token: @token), 'Accept' => 'application/json')
                body = parse(response)

                unless response.success?
                    meta = body['meta'] || {}
                    raise ApiError, "Foursquare API #{response.status}: #{meta['errorType']} #{meta['errorDetail']}".squeeze(' ').strip
                end

                body
            end

            def parse(response)
                JSON.parse(response.body.to_s)
            rescue JSON::ParserError
                raise ApiError, "Foursquare API returned a non-JSON response (HTTP #{response.status})"
            end

  end
end
