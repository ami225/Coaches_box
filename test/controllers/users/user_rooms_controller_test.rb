require 'test_helper'

class Users::UserRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_user_rooms_show_url
    assert_response :success
  end

end
