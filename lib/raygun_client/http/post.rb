module RaygunClient
  module HTTP
    class Post
      attr_reader :data

      dependency :telemetry, ::Telemetry
      dependency :logger, ::Telemetry::Logger

      def self.build
        new.tap do |instance|
          ::Telemetry.configure instance
          ::Telemetry::Logger.configure instance
        end
      end

      def self.configure(receiver, attr_name=nil)
        attr_name ||= :post
        build.tap do |instance|
          receiver.raygun_post = instance
          receiver.send "#{attr_name}=", instance
        end
      end

      def self.call(data)
        instance = build
        instance.(data)
      end

      def call(data)
        logger.trace "Posting to Raygun"
        json_text = Data::Serializer::JSON::Write.(data)

        response = post json_text

        telemetry.record :posted, Telemetry::Data.new(data, response)

        logger.debug "Posted to Raygun (Status Code: #{response.status_code}, Reason Phrase: #{response.reason_phrase})"

        response
      end

      def hostname
        'api.raygun.io'
      end

      def path
        '/entries'
      end

      def api_key
        ENV['RAYGUN_API_KEY']
      end

      def uri
        URI::HTTPS.build :host => hostname, :path => path
      end

      def post(request_body)
        ::HTTP::Commands::Post.(request_body, uri, 'X-ApiKey' => api_key)
      end

      def self.register_telemetry_sink(post)
        sink = Telemetry.sink
        post.telemetry.register sink
        sink
      end

      module Telemetry
        class Sink
          include ::Telemetry::Sink

          record :posted
        end

        Data = Struct.new :data, :response

        def self.sink
          Sink.new
        end
      end
    end
  end
end
