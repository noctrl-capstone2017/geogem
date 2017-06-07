# Teachers Login Test
# Teacher login information tests
# Author: Meagan Moore & Steven Royster

require 'test_helper'
require 'login_session_helper'

class TeachersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = teachers(:one)
  end
  
  # Test logging in as a user with invalid credentials
  # Assure that the flash worked
  test "login with invalid information" do
    get login_path
    assert_template 'login_session/new'
    post login_path, params: { login_session: { user_name: "", password: "" } }
    assert_template 'login_session/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  # Test the admin page guard
  test "login as non-admin with valid information and test the admin guard" do
    get login_path
    assert_template 'login_session/new'
    post login_path, params: { login_session: { user_name: @teacher.user_name, password: "password", id: 4 } }
    get admin_path
    assert flash.empty?
  end
  
  # test for flash
  # Author: Meagan Moore & Steven Royster
  test "should flash incorrect username/password combination" do
    get login_path
    assert_template 'login_session/new'
    post login_path, params: { login_session: { user_name: "", password: "" } }
    assert_template 'login_session/new'
    assert_not flash.empty?
  end
  
end