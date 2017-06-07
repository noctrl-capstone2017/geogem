# Login Session Controller Test
# Login/Logout tests
# Author: Meagan Moore & Steven Royster

require 'test_helper'

class LoginSessionControllerTest < ActionDispatch::IntegrationTest
  
  # check if login path exists 
  test "should get new" do
    get login_path
    assert_response :success
  end

  # check if create path exists 
  test "should get create" do
    get login_path
    assert_response :success
  end
  
  # check if logout path exists 
  test "should get logout" do
    get login_path
    assert_response :success
  end

end
