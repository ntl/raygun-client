module EventStore
  module Client
    module HTTP
      class EventData
        class IdentityError < RuntimeError; end

        include Schema::DataStructure

        dependency :uuid, UUID::Random
        dependency :logger, Telemetry::Logger

        attribute :type
        attribute :data
        attribute :metadata

        def configure_dependencies
          UUID::Random.configure self
          Telemetry::Logger.configure self
        end

        def digest
          "Type: #{type}"
        end

        def self.logger
          Telemetry::Logger.get self
        end

        class Write < EventData
          attribute :id

          def assign_id
            raise IdentityError, "ID is already assigned (ID: #{id})" unless id.nil?
            self.id = uuid.get
          end

          def serialize
            json_formatted_data.to_json
          end

          def json_formatted_data
            json_data = {
              'eventId' => id,
              'eventType' => type
            }

            json_data['data'] = Casing::Camel.(data) if data
            json_data['metadata'] = Casing::Camel.(metadata) if metadata

            json_data
          end
        end
      end
    end
  end
end
