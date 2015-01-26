require 'active_resource'

class Campaign
  class Growthspace
    class Subscriber < ActiveResource::Base
      self.site = 'https://www.growthspaces.org/api/v1'
      cattr_accessor :static_headers
      cattr_accessor :access_id
      cattr_accessor :access_secret
      self.static_headers = headers

      schema do
        string :first_name
        string :last_name
        string :email
        string :language_code
        string :route_id
      end

      def self.headers
        new_headers = static_headers.clone
        new_headers['access_id'] = growthspaces_access_id
        new_headers['access_secret'] = growthspaces_access_secret
        new_headers
      end

      def self.growthspaces_access_id
        access_id || ENV['growthspaces_access_id']
      end

      def self.growthspaces_access_secret
        access_secret || ENV['growthspaces_access_secret']
      end
    end
  end
end
