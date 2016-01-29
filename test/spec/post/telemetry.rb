require_relative '../spec_init'

context "Post Telemetry" do
  context "Post" do
    data = RaygunClient::Controls::Data.example
    post = RaygunClient::HTTP::Post.build

    sink = RaygunClient::HTTP::Post.register_telemetry_sink(post)

    post.(data)

    test "Records posted telemetry" do
      assert(sink.recorded_posted?)
    end

    context "Telemetry data" do
      test "Data" do
        assert(sink.recorded_posted? { |record| record.data.data == data })
      end

      test "Response" do
        assert(!sink.recorded_posted? { |record| record.data.response.nil? })
      end
    end
  end
end
