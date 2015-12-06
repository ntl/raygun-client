require_relative 'spec_init'

describe "Post Telemetry" do
  context "Post" do
    data = RaygunClient::Controls::Data.example
    post = RaygunClient::HTTP::Post.build

    sink = RaygunClient::HTTP::Post.register_telemetry_sink(post)

    post.(data)

    specify "Records posted telemetry" do
      assert(sink.recorded_posted?)
    end

    context "Telemetry data" do
      specify "Data" do
        assert(sink.recorded_posted? { |record| record.data.data == data })
      end

      specify "Response" do
        refute(sink.recorded_posted? { |record| record.data.response.nil? })
      end
    end
  end
end
