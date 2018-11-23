require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Aktenkoffer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    authentication_name = ENV.fetch('AUTHENTICATION_NAME', nil)
    authentication_password = ENV.fetch('AUTHENTICATION_PASSWORD', nil)
    config.authentication_options = {
      name: authentication_name,
      password: authentication_password,
      unless: -> { authentication_name.blank? || authentication_password.blank? }
    }
  end
end
