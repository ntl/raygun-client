module RaygunClient
  class ErrorData
    class Serialize
      attr_reader :error_data

      def initialize(error_data)
        @error_data = error_data
      end

      def self.build(error_data)
        new error_data
      end

      def self.call(error_data)
        instance = self.build error_data
        instance.()
      end

      def call
        ::JSON.generate(json_formatted_data)
      end

      def json_formatted_data
        data = {}

        data[:occurred_on] = error_data.occurred_time

        details = {}

        details[:machine_name] = error_data.machine_name

        details[:client] = error_data.client.to_h

        error = {}
        error[:class_name] = error_data.error.class_name
        error[:message] = error_data.error.message

        stack_trace = []
        error_data.error.stack_trace.each do |stack_frame|
          frame = {}
          frame[:line_number] = stack_frame.line_number
          frame[:file_name] = stack_frame.filename
          frame[:method_name] = stack_frame.method_name
          stack_trace << frame
        end

        error[:stack_trace] = stack_trace

        details[:error] = error

        data[:details] = details

        json_data = Casing::Camel.(data)

        json_data
      end
    end
  end
end
