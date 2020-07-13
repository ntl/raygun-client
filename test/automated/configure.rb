require_relative './automated_init'

context "Configure a Receiver" do
  context "Default attribute name" do
    test "The receiver has an instance of the post object" do
      receiver = OpenStruct.new

      RaygunClient::HTTP::Post.configure(receiver)

      assert(receiver.raygun_post.is_a?(RaygunClient::HTTP::Post))
    end
  end

  context "Specific attribute name" do
    test "The receiver has an instance of the post object" do
      receiver = OpenStruct.new

      RaygunClient::HTTP::Post.configure(receiver, attr_name: :other_attr)

      assert(receiver.other_attr.is_a?(RaygunClient::HTTP::Post))
    end
  end
end
