require_relative 'spec_init'

describe "Data Equality" do
  specify "Data object equality can be tested" do
    data_1 = RaygunClient::Controls::Data.example
    data_2 = RaygunClient::Controls::Data.example

    assert(data_1 == data_2)
  end
end
