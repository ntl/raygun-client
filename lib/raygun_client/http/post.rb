module RaygunClient
  module HTTP
    class Post
      attr_reader :data

      dependency :session
      dependency :telemetry, ::Telemetry

      def self.build
        new.tap do |instance|
          Session.configure instance
          ::Telemetry.configure instance
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
        json_text = Data::Serializer::JSON::Write.(data)

        response = session.post json_text

        # telemetry.record :posted, Telemetry::Data.new(data, response)
        telemetry.record :posted, Telemetry::Data.new(data, response)

        response
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
