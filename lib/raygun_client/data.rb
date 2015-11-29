module RaygunClient
  class Data
    include Schema::DataStructure

    attribute :occurred_time, String
    attribute :machine_name, String
    attribute :client, ClientInfo
    attribute :error, ErrorData

    module Serializer
      def self.json
        JSON
      end

      module JSON
        module Write
          def self.call(error_data)
            Serialize::Write.(error_data)
          end
        end
      end
    end
  end
end
