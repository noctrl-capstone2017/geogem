# Login Session Controller Test - login/logout tests
# Author: Meagan Moore & Steven Royster

require 'test_helper'

class LoginSessionControllerTest < ActionDispatch::IntegrationTest

  #
  # 1) check pulse of all login_session pages
  #
  test 'check pulse of all login_session pages' do
    get login_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Login ◆ GeoGem" }

    get logout_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Logout ◆ GeoGem" }
  end

  #
  # 2) check details of Login page: proper form inputs and submit button
  #
  test "check details of Login page" do
    get login_path
    assert_response :success
    assert_select 'form input[type=password]'
    assert_select 'form input[type=password]#login_session_password'
    assert_select 'form input[type=text]#login_session_user_name'
    assert_select 'form input[type=submit][value="Log in"]'
  end

  #
  # 3) check details of Logout page: back to login link, student art image
  #
  test "check details of Logout page" do
    get logout_path
    assert_response :success
    assert_select "a", :href => "/login"
    assert_select "img", { :count => 1, :alt => "Student Art" }
    assert_select "a", :href => "/about_student_art"
    assert_select "form", false, "This page must contain no forms"
  end

  #
  # 4) test root path: should got to Login page
  #
  test "check root path goes to Login page" do
    get root_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Login ◆ GeoGem" }
  end

end
