module RaygunClient
  class ErrorData
    include Schema::DataStructure

    class ClientInfo
      include Schema::DataStructure

      attribute :name, String
      attribute :version, String
      attribute :client_url, String

      def self.build
        instance = new

        instance.name = RaygunClient::ClientInfo.name
        instance.version = RaygunClient::ClientInfo.version
        instance.client_url = RaygunClient::ClientInfo.url

        instance
      end
    end

    class Error
      include Schema::DataStructure

      class StackFrame
        include Schema::DataStructure

        attribute :line_number, Integer
        attribute :filename, String # file_name
        attribute :method_name, String
      end

      attribute :class_name, String
      attribute :message, String
      attribute :stack_trace, Array[StackFrame]
    end

    attribute :occurred_time, String # occurred_on
    attribute :machine_name, String
    attribute :client, ClientInfo
    attribute :error, Error
  end
end
