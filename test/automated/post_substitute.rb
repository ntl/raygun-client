require_relative './automated_init'

context "Post Substitute" do
  data = Controls::Data.example

  substitute = RaygunClient::HTTP::Post::Substitute.build

  refute(substitute.posted?)

  substitute.(data)

  test "Posted" do
    assert(substitute.posted?)
  end

  context "Match Posted Data" do
    context "Correct" do
      posted = substitute.posted?(data)

      test do
        assert(posted)
      end
    end

    context "Incorrect" do
      other_data = Controls::Data.example
      other_data.machine_name = Controls::Random.example

      posted = substitute.posted?(other_data)

      test do
        refute(posted)
      end
    end
  end
end
