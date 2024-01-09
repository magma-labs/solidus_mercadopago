# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)
require 'solidus_mercadopago/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_mercadopago'
  s.version     = SolidusMercadopago::VERSION
  s.summary     = 'Solidus plugin to integrate Mercado Pago'
  s.description = 'Integrates Mercado Pago with Solidus'

  s.author    = 'Jonathan Tapia'
  s.email     = 'jonathan.tapia@magmalabs.io'
  s.homepage  = 'http://github.com/magma-labs/solidus_mercadopago'
  s.license   = 'BSD-3-Clause'

  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  s.test_files = Dir['spec/**/*']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = ['>= 2.5', '< 4.0']

  s.add_dependency 'rest-client'
  s.add_dependency 'solidus_core', ['>= 3.2', '< 5']
  s.add_dependency 'solidus_support', '~> 0.5'

  s.add_development_dependency 'solidus_backend'
  s.add_development_dependency 'solidus_frontend'
  s.add_development_dependency 'solidus_dev_support', '~> 2.5'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'capybara-accessible'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'webmock'
end
