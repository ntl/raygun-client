module RaygunClient
  module Controls
    module Error
      class Example < StandardError; end

      def self.class_name
        Example.name
      end

      def self.message
        'An example error'
      end

      def self.example
        error = Example.new message
        error.set_backtrace Backtrace.example
        error
      end

      module Backtrace
        def self.example
          [
            Frames::First.text,
            Frames::Second.text,
            Frames::Third.text
          ]
        end

        module Frames
          module First
            def self.text
              "#{filename}:#{line_number}:in `#{method_name}'"
            end

            def self.line_number
              111
            end

            def self.filename
              'some_file.rb'
            end

            def self.method_name
              'some_method'
            end
          end

          module Second
            def self.data
              {
                'lineNumber' => line_number,
                'fileName' => filename,
                'methodName' => method_name
              }
            end

            def self.line_number
              11
            end

            def self.filename
              'some_other_file.rb'
            end

            def self.method_name
              'some_other_method'
            end
          end

          module Third
            def self.data
              {
                'lineNumber' => line_number,
                'fileName' => filename,
                'methodName' => method_name
              }
            end

            def self.line_number
              1
            end

            def self.filename
              'yet_another_file.rb'
            end

            def self.method_name
              'yet_another_method'
            end
          end
        end
      end
    end
  end
end
