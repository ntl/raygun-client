require_relative 'spec_init'

describe "Configure a Receiver" do
  specify "The receiver has an instance of the post oobject" do
    receiver = OpenStruct.new

    RaygunClient::HTTP::Post.configure receiver

    assert(receiver.raygun_post.is_a? RaygunClient::HTTP::Post)
  end
end
