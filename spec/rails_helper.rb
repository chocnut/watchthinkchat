require 'common_helper'

require 'capybara/rspec'
require 'draper/test/rspec_integration'
require 'capybara/poltergeist'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

module Features
  include Formulaic::Dsl
end

RSpec.configure do |config|
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
  config.before do
    ActiveRecord::Base.observers.disable :all
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 200)
end

Capybara.configure do |config|
  config.always_include_port = true
  config.javascript_driver = :poltergeist
  config.server_port = 7171
end
