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

    def to_h
      raw_data = {}

      raw_data[:occurred_on] = occurred_time

      details = {}

      details[:machine_name] = machine_name

      details[:client] = client.to_h

      error = {}
      error[:class_name] = self.error.class_name
      error[:message] = self.error.message

      stack_trace = []
      self.error.backtrace.each do |frame|
        frame_data = {}
        frame_data[:file_name] = frame.filename
        frame_data[:line_number] = frame.line_number
        frame_data[:method_name] = frame.method_name
        stack_trace << frame_data
      end

      error[:stack_trace] = stack_trace

      details[:error] = error

      details[:tags] = tags unless tags.empty?
      details[:user_custom_data] = custom_data unless custom_data.empty?

      raw_data[:details] = details

      raw_data
    end

    module Serializer
      def self.json
        JSON
      end

      def self.raw_data(instance)
        instance.to_h
      end

      module JSON
        def self.serialize(raw_data)
          formatted_data = Casing::Camel.(raw_data)
          ::JSON.generate(formatted_data)
        end
      end
    end
  end
end
