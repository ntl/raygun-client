module RaygunClient
  module HTTP
    class Session
      dependency :logger, Telemetry::Logger

      def self.configure(instance)
        instance.session = new
      end
    end
  end
end
