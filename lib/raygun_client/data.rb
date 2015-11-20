module RaygunClient
  class Data
    include Schema::DataStructure

    attribute :occurred_time, String
    attribute :machine_name, String
    attribute :client, ClientInfo
    attribute :error, ErrorData
  end
end
