require 'test_helper'

class FavoriteCoachesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get favorite_coaches_index_url
    assert_response :success
  end
end
