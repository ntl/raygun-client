module RaygunClient
  class Settings < ::Settings
    def self.instance
      @instance ||= build
    end

    def self.data_source
      'settings/raygun_client.json'
    end

    def self.set(receiver)
      instance.set(receiver)
    end
  end
end
