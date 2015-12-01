module RaygunClient
  class Data
    module Serialize
      module Write
        attr_reader :data

        def self.call(data)
          ::JSON.generate(
            formatted_data(
              raw_data(data)
            )
          )
        end

        def self.raw_data(data)
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

          details[:user_custom_data] = data.custom_data

          raw_data[:details] = details

          raw_data
        end

        def self.formatted_data(raw_data)
          Casing::Camel.(raw_data)
        end
      end
    end
  end
end
