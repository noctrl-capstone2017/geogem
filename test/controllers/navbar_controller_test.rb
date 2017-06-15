# Author: Carolyn C
# Tests specific pages with the Navbar
require 'test_helper'

class NavbarControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)
  end

  # if on help page, it shoud be navbar1
  test "should get navbar1 for help" do
    log_in_as(@teacher)
    get help_path
    assert_response :success
  end
    
  # if on login page, it should be navbar2
  test "should get navbar2" do
    get login_path
    assert_response :success
  end
    
  # if on about1, it should be navbar3  
  test "should get navbar3 for about1" do
    get about_path
    assert_response :success
  end
    
  # if on about2, it should be navbar3
  test "should get navbar3 for about2" do
    get about2_path
    assert_response:success
  end
end
