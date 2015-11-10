module RaygunClient
  module HTTP
    class Session
      dependency :logger, Telemetry::Logger

      def connection
        @connection ||= connect
      end

      def tcp_connection
        @tcp_connection ||= TCPSocket.new hostname, 443
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

      def post(request_body)
        request = ::HTTP::Protocol::Request.new("POST", path)

        set_headers(request, request_body.bytesize)

        start_request(request)

        logger.trace "Posting (Content Length: #{request_body.size})"
        logger.data request_body
        connection.write request_body
        logger.debug "Posted (Content Length: #{request_body.size})"

        response = start_response

        close_connection(response)

        response
      end

      def set_headers(request, content_length)
        request['Host'] = hostname
        request['Content-Length'] = content_length
        request['X-ApiKey'] = api_key
      end

      def start_request(request)
        logger.trace "Transmitting request (Connection: #{connection.inspect})"
        logger.data request
        connection.write request.to_s
        logger.debug "Transmitted request (Connection: #{connection.inspect})"
      end

      def start_response
        builder = ::HTTP::Protocol::Response::Builder.build
        until builder.finished_headers?
          next_line = connection.gets
          logger.data "Read #{next_line.chomp}"
          builder << next_line
        end
        builder.message
      end

      def close_connection(response)
        connection.close if response["Connection"] == "close"
      end

      def connect
        ssl_context = OpenSSL::SSL::SSLContext.new
        ssl_context.set_params verify_mode: OpenSSL::SSL::VERIFY_NONE

        ssl_socket = OpenSSL::SSL::SSLSocket.new tcp_connection, ssl_context
        ssl_socket.sync_close = true
        ssl_socket.connect
        ssl_socket
      end

      def self.logger
        @logger ||= Telemetry::Logger.build self
      end
    end
  end
end
