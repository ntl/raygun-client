require_relative 'bench_init'

context "Data Serialization" do
  test "Converts to JSON text" do
    control_json_text = RaygunClient::Controls::Data::JSON.text

    data = RaygunClient::Controls::Data.example

    json_text = Serialize::Write.(data, :json)

    __logger.focus control_json_text
    __logger.focus json_text

    assert(json_text == control_json_text)
  end
end
