require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups(assets: %w(development test)))


begin
  require 'spree_frontend'
rescue LoadError
  # spree_frontend is not available.
end
      
begin
  require 'spree_backend'
rescue LoadError
  # spree_backend is not available.
end
      
begin
  require 'spree_api'
rescue LoadError
  # spree_api is not available.
end
      require 'solidus_mercadopago'

module Dummy
  class Application < Rails::Application
    # Load application's model / class decorators
    initializer 'spree.decorators' do |app|
      config.to_prepare do
        Dir.glob(Rails.root.join('app/**/*_decorator*.rb')) do |path|
          require_dependency(path)
        end
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end


