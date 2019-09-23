require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @topic = @user.topics.build(title: "Test topic")
  end

  test "should be valid" do
    assert @topic.valid?
  end

  test "user id should be present" do
    @topic.user_id = nil
    assert_not @topic.valid?
  end

  test "title should be present" do
    @topic.title = " "
    assert_not @topic.valid?
  end

  test "title should be at most 50 characters" do
    @topic.title = "a" * 51
    assert_not @topic.valid?
  end

  test "order should be most recent first" do
    assert_equal topics(:most_recent), Topic.first
  end

end
