module RaygunClient
  module HTTP
    class Session
      dependency :logger, Telemetry::Logger

      def self.build
        logger.trace "Building HTTP session"

        new.tap do |instance|
          Telemetry::Logger.configure instance
          logger.debug "Built HTTP session"
        end
      end

      def self.configure(receiver)
        session = build
        receiver.session = session
        session
      end

      def uri
        'api.raygun.io'
      end

      def self.logger
        @logger ||= Telemetry::Logger.build self
      end
    end
  end
end
