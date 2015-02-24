ENV['RAILS_ENV'] ||= 'test'
require 'shoulda/matchers'
require 'rspec/rails'

Dir['../../spec/factories/*.rb'].each { |file| require_relative file }
