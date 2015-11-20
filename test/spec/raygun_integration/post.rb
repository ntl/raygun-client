require_relative '../spec_init'

describe "Post Error Data to the Raygun API" do
  specify "Results in HTTP Status of 202 Accepted" do
    error_data = RaygunClient::Controls::Data.example
    response = RaygunClient::HTTP::Post.(error_data)

    assert(response.status_code == 202)
  end
end
