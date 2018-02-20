# Author: Meagan Moore & Steven Royster & someone else??
require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)
  end

  #
  # 1) check pulse of all static pages: existence and title
  #
  test 'check pulse of all static pages' do
    get root_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Login ◆ GeoGem" }

    get login_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Login ◆ GeoGem" }

    get about_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "About ◆ GeoGem" }

    get about_student_art_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "About Student Art ◆ GeoGem" }

    log_in_as(@teacher)     # must login for help page now
    get help_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "Help ◆ GeoGem" }
  end

  #
  # 2) check details of About page
  #
  test "check details of about page" do
    get about_url
    assert_response :success
    assert_select "a", :href => "/login", :text => "Back to Login"
    assert_select "h3", :text => "Acknowledgements"
    assert_select "h3", :text => "Meet the Team"
    assert_select "div.sq-about", { :count => 18 }
  end

  #
  # 3) check details of About Student Art page
  #
  test "check Student art page details" do
    get about_student_art_url
    assert_response :success
    assert_select "a", :href => "/login", :text => "Back to Login"
    assert_select "h2", /About student art - */
    # prof bill email should be in there, so they can email me artwork
    assert_select "a[href=?]", "mailto:wtkrieger@noctrl.edu"
  end

  #
  # 4) check details of Help page
  #
  test "should get help" do
    log_in_as(@teacher)     # must login for help page now
    get help_url
    assert_response :success
    assert_select "h2", "Help - frequently asked questions about GeoGem"
    # prof bill email should be in the help page, so I can help people (ha!)
    assert_select "a[href=?]", "mailto:wtkrieger@noctrl.edu"
  end

end
