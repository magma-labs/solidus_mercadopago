# frozen_string_literal: true

require 'spree/core'

module SolidusMercadopago
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree
    engine_name 'solidus_mercadopago'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_payment_network.register.payment_methods' do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::Mercadopago
    end
  end
end
