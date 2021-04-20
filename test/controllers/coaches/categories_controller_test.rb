require 'test_helper'

class Coaches::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coaches_categories_index_url
    assert_response :success
  end

  test "should get edit" do
    get coaches_categories_edit_url
    assert_response :success
  end
end
