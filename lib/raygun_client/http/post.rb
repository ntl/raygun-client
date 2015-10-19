module RaygunClient
  module HTTP
    class Post
      attr_reader :data

      dependency :session

      def initialize(data)
        @data = data
      end

      def self.build(error_data)
        data = ErrorData::Serialize.(error_data)
        instance = new data
        Session.configure instance
        instance
      end

      def self.call(error_data)
        instance = build error_data
        instance.()
      end

      def call
        response = session.post data
        response
      end
    end
  end
end
