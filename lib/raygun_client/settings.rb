module RaygunClient
  module Client
    module HTTP
      class Settings < ::Settings
        def self.instance
          @instance ||= build
        end

        def self.data_source
          'settings/raygun_client.json'
        end
      end
    end
  end
end
