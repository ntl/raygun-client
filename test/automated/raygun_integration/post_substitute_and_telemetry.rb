require_relative '../automated_init'

context "Post Substitute and Telemetry" do
  context "Records Posts" do
    data = RaygunClient::Controls::Data.example

    post = RaygunClient::HTTP::Post.build

    sink = RaygunClient::HTTP::Post.register_telemetry_sink(post)

    post_response = post.(data)

    context "Records telemetry about the post" do
      test "No block arguments" do
        posted = sink.posted?

        assert(sink)
      end

      test "data block argument" do
        posted = sink.posted? { |compare_data| compare_data == data }

        assert(posted)
      end

      test "data and response block arguments" do
        posted = sink.posted? { |compare_data, response|
          compare_data == data && response.code.to_i == 202
        }

        assert(posted)
      end
    end

    context "Access the data recorded" do
      test "No block arguments" do
        posts = sink.posts

        assert(posts.length == 1)
      end

      test "data block argument" do
        posts = sink.posts { |compare_data| compare_data == data }

        assert(posts.length == 1)
      end

      test "data and response block argument" do
        posts = sink.posts { |compare_data, response|
          compare_data == data && response.code.to_i == 202
        }

        assert(posts.length == 1)
      end

      test "no post matches block argument" do
        posts = sink.posts { false }

        assert(posts.empty?)
      end
    end
  end
end
