require_relative '../bench_init'

context "Post Error Data to the Raygun API" do
  test "Results in HTTP Status of 202 Accepted" do
    data = RaygunClient::Controls::Data.example
    response = RaygunClient::HTTP::Post.(data)

    assert(response.status_code == 202)
  end
end
