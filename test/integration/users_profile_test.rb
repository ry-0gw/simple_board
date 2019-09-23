require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "profile pagination" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'div.pagination'
    @user.topics.paginate(page: 1).each do |topic|
      assert_match topic.title, response.body
    end
  end

end
