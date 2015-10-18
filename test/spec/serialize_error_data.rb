require_relative 'spec_init'

describe "Error Data Serialization" do
  specify "Converts to JSON text" do
    compare_json_text = RaygunClient::Controls::ErrorData::JSON.text

    error_data = RaygunClient::Controls::ErrorData.example
    json_text = RaygunClient::ErrorData::Serialize.(error_data)

    assert(json_text == compare_json_text)
  end
end
