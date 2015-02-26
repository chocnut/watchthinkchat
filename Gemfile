source 'https://rubygems.org'
ruby '2.1.5'

# Core
gem 'rails', '4.1.8'
gem 'rails-observers'

# Data Storage
gem 'pg'
gem 'dalli'
gem 'connection_pool'
gem 'kgio'

# Authentication
gem 'devise'
gem 'devise_invitable'
gem 'devise-i18n'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'cancancan'
gem 'role_model'

# Public API
gem 'rest-client'
gem 'platform-api'
gem 'versionist'

# Assets CSS
gem 'sass-rails'
gem 'font-awesome-rails'
gem 'bootstrap-sass'

# Assets Javascript
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'angularjs-rails'
gem 'angular-ui-rails'
gem 'angular-ui-bootstrap-rails'
gem 'select2-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'lodash-rails'
gem 'rabl'
gem 'oj'
gem 'angular-rails-templates'

# HTML
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'tabletastic'
gem 'kaminari', '~> 0.15'
gem 'paperclip'

# Rails Frameworks
gem 'wicked'
gem 'acts_as_list'
gem 'active_type'
gem 'draper'
gem 'globalize'
gem 'route_translator'
gem 'rails-i18n'
gem 'i18n-active_record', github: 'svenfuchs/i18n-active_record'
gem 'i18n-one_sky', path: 'vendor/i18n-one_sky-ruby'
gem 'countries_and_languages', :require => 'countries_and_languages/rails'
gem 'activeresource'

group :test do
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
  gem 'shoulda-matchers', require: false
  gem 'simplecov'
  gem 'faker'
  gem 'capybara'
  gem 'poltergeist'
  gem 'capybara-screenshot'
  gem 'capybara-angular'
  gem 'launchy'
  gem 'vcr'
  gem 'formulaic'
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'assert_difference'
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'dotenv-rails'
  gem 'fuubar'
  gem 'rubocop'
end

group :development do
  gem 'rack-mini-profiler'
  gem 'quiet_assets'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-puma'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rb-fsevent', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :production do
  gem 'puma'
end

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
  gem 'airbrake'
  gem 'newrelic_rpm'
end

