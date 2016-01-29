require_relative '../spec_init'

context "Post Substitute" do
  context "Records Posts" do
    post_data = RaygunClient::Controls::Data.example
    substitute_post = RaygunClient::HTTP::Post::Substitute.build

    sink = substitute_post.sink

    post_response = substitute_post.(post_data)

    context "Records telemetry about the post" do
      test "No block arguments" do
        assert sink do
          posted?
        end
      end

      test "data block argument" do
        assert sink do
          posted? { |data| data == post_data}
        end
      end

      test "data and response block arguments" do
        assert sink do
          posted? { |data, response| data == post_data && response == post_response}
        end
      end
    end

    context "Access the data recorded" do
      test "No block arguments" do
        assert sink do
          posts.length == 1
        end
      end

      test "data block argument" do
        assert sink do
          sink.posts { |data| data == post_data}.length == 1
        end
      end

      test "data and response block argument" do
        assert sink do
          sink.posts { |data, response| data == post_data && response == post_response}.length == 1
        end
      end
    end
  end
end
