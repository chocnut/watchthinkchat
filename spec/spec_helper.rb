require 'common_helper'
require 'support/database_cleaner'

RSpec.configure do |config|
  # config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.before do
    ActiveRecord::Base.observers.disable :all
  end
end
