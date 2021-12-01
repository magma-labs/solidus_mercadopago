# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |name| "https://github.com/#{name}.git" }

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem 'solidus', github: 'solidusio/solidus', branch: branch

# Needed to help Bundler figure out how to resolve dependencies,
# otherwise it takes forever to resolve them.
# See https://github.com/bundler/bundler/issues/6677
gem 'rails', '>0.a'

# Provides basic authentication functionality for testing parts of your engine
gem 'byebug'
gem 'solidus_auth_devise'

case ENV['DB']
when 'mysql'
  gem 'mysql2', '~> 0.4.10'
when 'postgresql'
  gem 'pg', '~> 0.21'
else
  gem 'sqlite3'
end

group :test do
  gem 'rails-controller-testing'
end

gemspec

# Use a local Gemfile to include development dependencies that might not be
# relevant for the project or for other contributors, e.g.: `gem 'pry-debug'`.
send :eval_gemfile, 'Gemfile-local' if File.exist? 'Gemfile-local'
