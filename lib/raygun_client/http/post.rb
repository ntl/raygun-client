module RaygunClient
  module HTTP
    class Post
      include Configure
      include Dependency
      include Settings::Setting

      include ::Telemetry::Dependency
      include Log::Dependency

      setting :api_key

      attr_reader :data

      configure :raygun_post

      def self.build(connection: nil)
        instance = new
        RaygunClient::Settings.set(instance)
        instance
      end

      def self.call(data)
        instance = build
        instance.(data)
      end

      def call(data)
        logger.trace { "Posting to Raygun" }
        json_text = Transform::Write.(data, :json)

        response = post(json_text)

        telemetry.record(:posted, Telemetry::Data.new(data, response))

        logger.info { "Posted to Raygun (#{LogText::Posted.(data, response)})" }

        response
      end

      def self.host
        'api.raygun.io'
      end

      def self.path
        '/entries'
      end

      def self.uri
        @uri ||= URI::HTTPS.build(:host => host, :path => path)
      end

      def post(request_body)
        uri = self.class.uri

        response = Net::HTTP.post(uri, request_body, { 'X-ApiKey' => api_key })

        response
      end

      def self.register_telemetry_sink(post)
        sink = Telemetry.sink
        post.telemetry.register(sink)
        sink
      end

      module Telemetry
        class Sink
          include ::Telemetry::Sink

          record :posted

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

        Data = Struct.new(:data, :response)

        def self.sink
          Sink.new
        end
      end

      module Substitute
        def self.build
          substitute = Substitute::Post.new

          sink = RaygunClient::HTTP::Post.register_telemetry_sink(substitute)
          substitute.sink = sink

          substitute
        end

        class Post < HTTP::Post
          attr_accessor :sink

          def post(_)
          end

          def posted?(data=nil, &block)
            unless data.nil?
              block ||= proc { |posted_data|
                data == posted_data
              }
            end

            sink.posted?(&block)
          end
        end
      end

      module LogText
        module Posted
          def self.call(data, response)
            "Status Code: #{response&.code || '(none)'}, Reason Phrase: #{response&.message || '(none)'}, Error Message: #{data.error.message}, Custom Data: #{data.custom_data || '(none)'})"
          end
        end
      end
    end
  end
end
