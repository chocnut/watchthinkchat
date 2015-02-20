ENV['RAILS_ENV'] ||= 'test'
if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start 'rails'
end
require 'shoulda/matchers'
require 'rspec/rails'

Dir['../../spec/factories/*.rb'].each { |file| require_relative file }
