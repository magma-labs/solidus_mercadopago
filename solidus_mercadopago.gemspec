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

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.required_ruby_version = Gem::Requirement.new('~> 2.5')

  s.add_dependency 'deface', '~> 1.0'
  s.add_dependency 'rest-client'
  s.add_dependency 'solidus', ['>= 2.0', '< 3']
  s.add_dependency 'solidus_auth_devise', ['>= 2.0', '< 3']
  s.add_dependency 'solidus_support'

  s.add_development_dependency 'autoprefixer-rails'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'solidus_dev_support'
end
