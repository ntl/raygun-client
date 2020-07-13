module RaygunClient
  class Data
    include Schema::DataStructure

    attribute :occurred_time, String
    attribute :machine_name, String
    attribute :client, ClientInfo
    attribute :error, ErrorData
    attribute :tags, Array
    attribute :custom_data, Hash

    def ==(other)
      self.class == other.class &&
        occurred_time == other.occurred_time &&
        machine_name == other.machine_name &&
        client == other.client &&
        error == other.error
    end

    def transform_write(data)
      data[:occurred_on] = data.delete(:occurred_time)

      details = {}
      details[:machine_name] = data.delete(:machine_name)

      client = data.delete(:client)
      details[:client] = client.to_h

      error = data.delete(:error)

      error_data = {}
      error_data[:class_name] = error.class_name
      error_data[:message] = error.message

      stack_trace = []
      error.backtrace.each do |frame|
        frame_data = {}
        frame_data[:file_name] = frame.filename
        frame_data[:line_number] = frame.line_number
        frame_data[:method_name] = frame.method_name
        stack_trace << frame_data
      end

      error_data[:stack_trace] = stack_trace

      details[:error] = error_data

      tags = data.delete(:tags)
      details[:tags] = tags unless tags.empty?

      custom_data = data.delete(:custom_data)
      details[:user_custom_data] = custom_data unless custom_data.empty?

      data[:details] = details
    end

    module Transform
      def self.json
        JSON
      end

      def self.raw_data(instance)
        instance.attributes
      end

      module JSON
        def self.write(raw_data)
          formatted_data = Casing::Camel.(raw_data)
          ::JSON.generate(formatted_data)
        end
      end
    end
  end
end
