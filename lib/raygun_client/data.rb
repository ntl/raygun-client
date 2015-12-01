module RaygunClient
  class Data
    include Schema::DataStructure

    attribute :occurred_time, String
    attribute :machine_name, String
    attribute :client, ClientInfo
    attribute :error, ErrorData
    attribute :custom_data, Hash

    def ==(other)
      self.class == other.class &&
        occurred_time == other.occurred_time &&
        machine_name == other.machine_name &&
        client == other.client &&
        error == other.error
    end

    module Serializer
      def self.json
        JSON
      end

      module JSON
        module Write
          def self.call(data)
            Serialize::Write.(data)
          end
        end
      end
    end
  end
end
