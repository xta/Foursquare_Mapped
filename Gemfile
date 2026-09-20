source 'https://rubygems.org'
ruby '3.4.7'

# Rails
gem 'rails', '~> 8.0.2'
gem 'sprockets-rails'          # classic asset pipeline (app uses //= require manifests)
gem 'sassc-rails'              # compiles the .css.scss stylesheets
gem 'bootstrap-sass', '~> 3.4' # Bootstrap 3, matches the existing markup
gem 'jquery-rails'             # jquery + jquery_ujs (powers data-method links)
gem 'terser'                   # JS compressor for production (replaces uglifier)

# json 3.x removed the `quirks_mode` option that ActiveSupport 8.0 still passes
# in active_support/json/{encoding,decoding}.rb. execjs and faraday both declare
# an unbounded `json` dependency, so without this pin Bundler picks json 3 and
# every JSON column read/write raises "unknown keyword: quirks_mode".
gem 'json', '~> 2.9'

# Database
gem 'pg', '~> 1.5'

# Server
gem 'puma', '~> 6.4'

# Authentication
gem 'devise', '~> 4.9'
gem 'omniauth', '~> 2.1'
gem 'omniauth-oauth2', '~> 1.8'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
# NOTE: the omniauth-foursquare gem is abandoned (2014, requires omniauth 1.x).
# Its strategy now lives in lib/omniauth/strategies/foursquare.rb.

# APIs
gem 'faraday', '~> 2.9'
gem 'hashie', '~> 5.0'
# NOTE: the foursquare2 gem is abandoned (2014, pins faraday 0.x).
# lib/foursquare_wrapper/ now calls the v2 API directly over faraday.

# Background Jobs
gem 'sucker_punch', '~> 3.2'

# Pagination
gem 'kaminari'

gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'rspec-rails', '~> 8.0'
  gem 'awesome_print'
  gem 'pry-rails'
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
end

group :development do
  gem 'web-console'
end
