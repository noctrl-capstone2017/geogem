# Login Session Controller Test
# Login/Logout tests
# Author: Meagan Moore & Steven Royster

require 'test_helper'

class LoginSessionControllerTest < ActionDispatch::IntegrationTest
  
  # test login page pulse
  test 'should get login page' do
    get login_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Login ◆ GeoGem" }
  end

  # test login page details: proper form inputs
  test "should check login page details" do
    get login_path
    assert_response :success
    assert_select 'form input[type=password]'
    assert_select 'form input[type=password]#login_session_password'
    assert_select 'form input[type=text]#login_session_user_name'
    assert_select 'form input[type=submit][value="Log in"]'
  end

  # test logout page pulse 
  test "should get logout page" do
    get logout_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Logout ◆ GeoGem" }
  end

  # test logout page details: back to login link, student art image and link
  test "should check logout page details" do
    get logout_path
    assert_response :success
    assert_select "a", :href => "/login"
    assert_select "img", { :count => 1, :alt => "Student Art" }
    assert_select "a", :href => "/about_student_art"
    assert_select "form", false, "This page must contain no forms"
  end

  # test root path goes to login page, too
  test "should get login page from root path" do
    get root_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Login ◆ GeoGem" }
  end
end
