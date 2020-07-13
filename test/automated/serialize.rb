require_relative './automated_init'

context "Data Serialization" do
  test "Converts to JSON text" do
    control_json_text = RaygunClient::Controls::Data::JSON.text

    data = RaygunClient::Controls::Data.example

    json_text = Transform::Write.(data, :json)

    assert(json_text == control_json_text)
  end
end
