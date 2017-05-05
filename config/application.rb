require_relative 'boot'

require 'rails/all'

#carrierwave
require 'carrierwave'
require 'carrierwave/orm/activerecord'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #Japanese
    config.i18n.default_locale = :ja

    #not to make waste fail
    config.generators do |g|
      g.helper false
      g.assets false
      g.test_framework false
    end

    #carrierwave
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
  end
end
