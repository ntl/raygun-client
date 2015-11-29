module RaygunClient
  module HTTP
    class Post
      attr_reader :data

      dependency :session

      def initialize(data)
        @data = data
      end

      def self.build(data)
        data = Data::Serializer::JSON::Write.(data)
        instance = new data
        Session.configure instance
        instance
      end

      def self.call(data)
        instance = build data
        instance.()
      end

      def call
        response = session.post data
        response
      end
    end
  end
end
