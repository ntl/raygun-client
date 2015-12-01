module RaygunClient
  class Data
    class ClientInfo
      include Schema::DataStructure

      attribute :name, String
      attribute :version, String
      attribute :client_url, String

      def ==(other)
        name == other.name &&
          version == other.version &&
          client_url == other.client_url
      end

      def self.build
        instance = new

        instance.name = RaygunClient::ClientInfo.name
        instance.version = RaygunClient::ClientInfo.version
        instance.client_url = RaygunClient::ClientInfo.url

        instance
      end
    end
  end
end
