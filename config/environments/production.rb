require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :terser
  # config.assets.css_compressor = :sass

  # Do not fall back to the asset pipeline if a precompiled asset is missing.
  config.assets.compile = false

  # Serve static files from public/ (set RAILS_SERVE_STATIC_FILES if fronted by nginx/Apache).
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'info')
  config.logger = ActiveSupport::TaggedLogging.logger($stdout)

  # Enable locale fallbacks for I18n.
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
