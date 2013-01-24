require 'test_helper'

class PostControllerTest < ActionController::TestCase
  test "should get post_list" do
    get :post_list
    assert_response :success
  end

  test "should get post_new" do
    get :post_new
    assert_response :success
  end

  test "should get post_view" do
    get :post_view
    assert_response :success
  end

end
