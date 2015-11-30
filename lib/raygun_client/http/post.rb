module RaygunClient
  module HTTP
    class Post
      attr_reader :data

      dependency :session

      def self.build
        new.tap do |instance|
          Session.configure instance
        end
      end

      def self.configure(receiver)
        build.tap do |instance|
          receiver.raygun_post = instance
        end
      end

      def self.call(data)
        instance = build
        instance.(data)
      end

      def call(data)
        json_text = Data::Serializer::JSON::Write.(data)

        response = session.post json_text
        response
      end
    end
  end
end
