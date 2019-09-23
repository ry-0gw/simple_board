require 'test_helper'

class TopicsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "topic interface" do
    log_in_as(@user)
    get new_topic_path
    assert_no_difference 'Topic.count' do
      post topics_path, params: { topic: { title: "" } }
    end
    title = "Test topic"
    assert_difference 'Topic.count', 1 do
      post topics_path, params: { topic: { title: title } }
    end
    assert_redirected_to root_url
    get users_path(@user)
    assert_select 'a', text: '削除'
    first_topic = @user.topics.paginate(page: 1).first
    assert_difference 'Topic.count', -1 do
      delete topic_path(first_topic)
    end
    get user_path(users(:malory))
    assert_select 'a', text: '削除', count: 0
  end
end
