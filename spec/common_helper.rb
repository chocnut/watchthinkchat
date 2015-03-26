ENV['RAILS_ENV'] ||= 'test'
if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start 'rails'
end

require File.expand_path('../../config/environment', __FILE__)
require 'shoulda/matchers'
require 'rspec/rails'
ActiveRecord::Migration.maintain_test_schema!

Dir['../../spec/factories/*.rb'].each { |file| require_relative file }
