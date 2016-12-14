require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get activated" do
    get :confirm_email
    assert_response :success
  end

end
