require 'test_helper'

class HookControllerTest < ActionController::TestCase
  test "should get bounce" do
    get :bounce
    assert_response :success
  end

  test "should get unsubscribe" do
    get :unsubscribe
    assert_response :success
  end

  test "should get complaint" do
    get :complaint
    assert_response :success
  end

end
