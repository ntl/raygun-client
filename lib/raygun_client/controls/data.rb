module RaygunClient
  module Controls
    module Data
      def self.example(custom_data=nil, tags=nil, time: nil)
        custom_data ||= self.custom_data
        tags ||= self.tags
        time ||= self.time

        data = RaygunClient::Data.build

        data.occurred_time = time
        data.machine_name = machine_name
        data.tags = tags
        data.custom_data = custom_data

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

      def self.tags
        ['some-tag']
      end

      def self.custom_data
        { 'someKey' => 'some value' }
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
              'error' => Error.data,
              'tags' => Controls::Data.tags,
              'userCustomData' => Controls::Data.custom_data
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

        module Error
          def self.data
            error = {}
            error['className'] = Controls::Error.class_name
            error['message'] = Controls::Error.message

            stack_trace = StackTrace.data

            error['stackTrace'] = stack_trace

            error
          end

          module StackTrace
            def self.data
              [
                Frames::First.data,
                Frames::Second.data,
                Frames::Third.data
              ]
            end

            module Frames
              module First
                def self.data
                  {
                    'fileName' => Controls::Error::Backtrace::Frames::First.filename,
                    'lineNumber' => Controls::Error::Backtrace::Frames::First.line_number,
                    'methodName' => Controls::Error::Backtrace::Frames::First.method_name
                  }
                end
              end

              module Second
                def self.data
                  {
                    'fileName' => Controls::Error::Backtrace::Frames::Second.filename,
                    'lineNumber' => Controls::Error::Backtrace::Frames::Second.line_number,
                    'methodName' => Controls::Error::Backtrace::Frames::Second.method_name
                  }
                end
              end

              module Third
                def self.data
                  {
                    'fileName' => Controls::Error::Backtrace::Frames::Third.filename,
                    'lineNumber' => Controls::Error::Backtrace::Frames::Third.line_number,
                    'methodName' => Controls::Error::Backtrace::Frames::Third.method_name
                  }
                end
              end
            end
          end
        end
      end
    end
  end
end
