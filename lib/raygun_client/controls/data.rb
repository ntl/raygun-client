module RaygunClient
  module Controls
    module Data
      def self.example
        data = RaygunClient::Data.build

        data.occurred_time = time
        data.machine_name = machine_name

        data.client = RaygunClient::Data::ClientInfo.build

        data.error = Controls::ErrorData.example

        data
      end

      def self.time
        ::Controls::Time.reference
      end

      def self.machine_name
        'some machine name'
      end

      module JSON
        def self.text
          ::JSON.generate(data)
        end

        def self.data
          reference_time = Controls::Data.time

          {
            'occurredOn' => reference_time,
            'details' => {
              'machineName' => Controls::Data.machine_name,
              'client' => Client.data,
              'error' => ErrorData::JSON.data
            }
          }
        end

        module Client
          def self.data
            {
              'name' => ClientInfo.name,
              'version' => ClientInfo.version,
              'clientUrl' => ClientInfo.url
            }
          end
        end
      end
    end
  end
end
