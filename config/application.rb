require_relative 'boot'

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module FoursquareMapped
  class Application < Rails::Application
    config.load_defaults 8.0

    # Foursquare client id/secret and secret_key_base live in config/secrets.yml
    # (gitignored). Rails.application.secrets was removed in Rails 7.2, so the
    # same file is now read through config_for.
    config.foursquare = config_for(:secrets)
    config.secret_key_base = config.foursquare[:secret_key_base] if config.foursquare[:secret_key_base]

    # lib/ holds the Foursquare API wrapper and the OmniAuth strategy, both of
    # which are required explicitly rather than autoloaded.
    config.autoload_lib(ignore: %w[assets tasks omniauth foursquare_wrapper])
  end
end
