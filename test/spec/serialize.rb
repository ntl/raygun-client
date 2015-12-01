require_relative 'spec_init'

describe "Data Serialization" do
  specify "Converts to JSON text" do
    compare_json_text = RaygunClient::Controls::Data::JSON.text

    data = RaygunClient::Controls::Data.example

    json_text = Serialize::Write.(data, :json)

    assert(json_text == compare_json_text)
  end
end
