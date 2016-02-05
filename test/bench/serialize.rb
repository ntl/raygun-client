require_relative 'bench_init'

context "Data Serialization" do
  test "Converts to JSON text" do
    compare_json_text = RaygunClient::Controls::Data::JSON.text

    data = RaygunClient::Controls::Data.example

    json_text = Serialize::Write.(data, :json)

    assert(json_text == compare_json_text)
  end
end
