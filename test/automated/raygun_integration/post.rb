require_relative '../automated_init'

context "Post Error Data to the Raygun API" do
  test "Results in HTTP Status of 202 Accepted" do
    data = RaygunClient::Controls::Data.example

    response = RaygunClient::HTTP::Post.(data)

    assert(response.code.to_i == 202)
  end
end
