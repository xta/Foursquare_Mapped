require 'omniauth-oauth2'

# Replacement for the abandoned `omniauth-foursquare` gem (last released 2014,
# pinned to omniauth 1.x). Same strategy name and same auth hash shape, ported
# to omniauth 2.x / oauth2 2.x so it runs on current Rails.
module OmniAuth
  module Strategies
    class Foursquare < OmniAuth::Strategies::OAuth2
      API_VERSION = '20140806'.freeze

      option :name, 'foursquare'

      option :client_options,
             site: 'https://api.foursquare.com',
             authorize_url: 'https://foursquare.com/oauth2/authenticate',
             token_url: 'https://foursquare.com/oauth2/access_token',
             auth_scheme: :request_body

      # Foursquare returns the token as JSON but without a JSON content type,
      # and it does not accept HTTP Basic client authentication.
      option :token_params, parse: :json

      uid { raw_info['id'].to_s }

      info do
        {
          'email' => raw_info.dig('contact', 'email'),
          'first_name' => raw_info['firstName'],
          'last_name' => raw_info['lastName'],
          'name' => [raw_info['firstName'], raw_info['lastName']].compact.join(' '),
          'image' => photo_url,
          'location' => raw_info['homeCity'],
          'description' => raw_info['bio'],
          'urls' => { 'Foursquare' => "https://foursquare.com/user/#{raw_info['id']}" }
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def raw_info
        @raw_info ||= begin
          response = access_token.get(
            '/v2/users/self',
            params: { 'v' => API_VERSION, 'oauth_token' => access_token.token },
            headers: { 'Accept' => 'application/json' }
          )
          response.parsed.dig('response', 'user') || {}
        end
      end

      # Foursquare wants the token in the query string, not an Authorization header.
      def callback_url
        full_host + callback_path
      end

      private

      def photo_url
        photo = raw_info['photo']
        return nil unless photo.is_a?(Hash)

        "#{photo['prefix']}original#{photo['suffix']}"
      end
    end
  end
end

OmniAuth.config.add_camelization 'foursquare', 'Foursquare'
