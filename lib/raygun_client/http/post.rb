module RaygunClient
  module HTTP
    class Post
      include Settings::Setting
      include Dependency
      include Log::Dependency

      setting :api_key

      attr_reader :data

      dependency :telemetry, ::Telemetry

      def self.build(connection: nil)
        instance = new
        RaygunClient::Settings.set(instance)
        ::Telemetry.configure(instance)
        instance
      end

      def self.configure(receiver, attr_name=nil)
        attr_name ||= :raygun_post
        build.tap do |instance|
          receiver.send "#{attr_name}=", instance
        end
      end

      def self.call(data)
        instance = build
        instance.(data)
      end

      def call(data)
        logger.trace "Posting to Raygun"
        json_text = Serialize::Write.(data, :json)

        response = post(json_text)

        telemetry.record :posted, Telemetry::Data.new(data, response)

        logger.info "Posted to Raygun (#{LogText::Posted.(data, response)})"

        response
      end

      def self.host
        'api.raygun.io'
      end

      def self.path
        '/entries'
      end

      def self.uri
        @uri ||= URI::HTTPS.build :host => host, :path => path
      end

      def post(request_body)
        http_post.(request_body, self.class.uri, 'X-ApiKey' => api_key)
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

          module Assertions
            def posts(&blk)
              if blk.nil?
                return posted_records
              end

              posted_records.select do |record|
                blk.call(record.data.data, record.data.response)
              end
            end

            def posted?(&blk)
              if blk.nil?
                return recorded_posted?
              end

              recorded_posted? do |record|
                blk.call(record.data.data, record.data.response)
              end
            end
          end
        end

        Data = Struct.new :data, :response

        def self.sink
          Sink.new
        end
      end

      module Substitute
        def self.build
          Substitute::Post.build.tap do |substitute|
            sink = RaygunClient::HTTP::Post.register_telemetry_sink(substitute)
            substitute.sink = sink
          end
        end

        class Post < HTTP::Post
          attr_accessor :sink

          def self.build
            instance = new
            ::Telemetry.configure(instance)
            instance
          end
        end
      end

      module LogText
        module Posted
          def self.call(data, response)
            "Status Code: #{response.status_code}, Reason Phrase: #{response.reason_phrase}, Error Message: #{data.error.message}, Custom Data: #{data.custom_data || '(none)'})"
          end
        end
      end
    end
  end
end
