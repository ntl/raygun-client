module RaygunClient
  class Data
    class Serialize
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def self.build(data)
        new data
      end

      def self.call(data)
        instance = self.build data
        instance.()
      end

      def call
        ::JSON.generate(json_formatted_data)
      end

      def json_formatted_data
        raw_data = {}

        raw_data[:occurred_on] = data.occurred_time

        details = {}

        details[:machine_name] = data.machine_name

        details[:client] = data.client.to_h

        error = {}
        error[:class_name] = data.error.class_name
        error[:message] = data.error.message

        stack_trace = []
        data.error.backtrace.each do |line|
          frame = {}
          frame[:file_name] = line.filename
          frame[:line_number] = line.line_number
          frame[:method_name] = line.method_name
          stack_trace << frame
        end

        error[:stack_trace] = stack_trace

        details[:error] = error

        raw_data[:details] = details

        json_data = Casing::Camel.(raw_data)

        json_data
      end
    end
  end
end
