module RaygunClient
  module Controls
    module ErrorData
      def self.example
        error_data = RaygunClient::ErrorData.new

        error_data.occurred_time = time
        error_data.machine_name = machine_name

        error_data.client = RaygunClient::ErrorData::ClientInfo.build

        error = RaygunClient::ErrorData::Error.new
        error_data.error = error
        error.class_name = Controls::Error.class_name
        error.message = Controls::Error.message

        first_stack_frame = RaygunClient::ErrorData::Error::StackFrame.new
        first_stack_frame.line_number = Controls::Error::Backtrace::Frames::First.line_number
        first_stack_frame.filename = Controls::Error::Backtrace::Frames::First.filename
        first_stack_frame.method_name = Controls::Error::Backtrace::Frames::First.method_name

        second_stack_frame = RaygunClient::ErrorData::Error::StackFrame.new
        second_stack_frame.line_number = Controls::Error::Backtrace::Frames::Second.line_number
        second_stack_frame.filename = Controls::Error::Backtrace::Frames::Second.filename
        second_stack_frame.method_name = Controls::Error::Backtrace::Frames::Second.method_name

        third_stack_frame = RaygunClient::ErrorData::Error::StackFrame.new
        third_stack_frame.line_number = Controls::Error::Backtrace::Frames::Third.line_number
        third_stack_frame.filename = Controls::Error::Backtrace::Frames::Third.filename
        third_stack_frame.method_name = Controls::Error::Backtrace::Frames::Third.method_name

        stack_frames = []
        stack_frames << first_stack_frame
        stack_frames << second_stack_frame
        stack_frames << third_stack_frame

        error.stack_trace = stack_frames

        error_data
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
          reference_time = Controls::ErrorData.time

          {
            'occurredOn' => reference_time,
            'details' => {
              'machineName' => Controls::ErrorData.machine_name,
              'client' => Client.data,
              'error' => Error.data,
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
            {
              'className' => Controls::Error.class_name,
              'message' => Controls::Error.message,
              'stackTrace' => StackTrace.data
            }
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
                    'lineNumber' => Controls::Error::Backtrace::Frames::First.line_number,
                    'fileName' => Controls::Error::Backtrace::Frames::First.filename,
                    'methodName' => Controls::Error::Backtrace::Frames::First.method_name
                  }
                end
              end

              module Second
                def self.data
                  {
                    'lineNumber' => Controls::Error::Backtrace::Frames::Second.line_number,
                    'fileName' => Controls::Error::Backtrace::Frames::Second.filename,
                    'methodName' => Controls::Error::Backtrace::Frames::Second.method_name
                  }
                end
              end

              module Third
                def self.data
                  {
                    'lineNumber' => Controls::Error::Backtrace::Frames::Third.line_number,
                    'fileName' => Controls::Error::Backtrace::Frames::Third.filename,
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
