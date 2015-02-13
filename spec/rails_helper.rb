if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'shoulda/matchers'
require 'draper/test/rspec_integration'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }
Dir['../../spec/factories/*.rb'].each { |file| require_relative file }

module Features
  # Extend this module in spec/support/features/*.rb
  include Formulaic::Dsl
end

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.include Features, type: :feature
  config.include Devise::TestHelpers, type: :controller
  config.include JsonApiHelpers, type: :controller
  config.include JsonApiHelpers, type: :request
  config.include IntegrationHelpers, type: :feature
  config.include Warden::Test::Helpers, type: :feature
  config.include Capybara::Angular::DSL, type: :feature
end

ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :webkit
