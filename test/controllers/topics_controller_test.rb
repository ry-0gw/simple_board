require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @topic = topics(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Topic.count' do
      post topics_path, params: { topic: { title: "Test title" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Topic.count' do
      delete topic_path(@topic)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    topic = topics(:ants)
    assert_no_difference 'Topic.count' do
      delete topic_path(topic)
    end
    assert_redirected_to root_url
  end

end
