# Author: Meagan Moore & Steven Royster & someone else??
require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @teacher = teachers(:one)
  end

  # test root path pulse
  test 'should get root path' do
    get root_path
    assert_response :success
    assert_select "title", "Login ◆ GeoGem"
  end

  # test About page pulse 
  test "should get about page" do
    get about_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "About ◆ GeoGem" }
  end

  # test About page details 
  test "should check about page details" do
    get about_url
    assert_response :success
    assert_select "a", :href => "/login", :text => "Back to Login"
    assert_select "h3", :text => "Acknowledgements"
    assert_select "h3", :text => "Meet the Team"
    assert_select "div.sq-about", { :count => 18 }
  end


  # test About Student Art page pulse
  test "should get about student art page" do
    get about_student_art_url
    assert_response :success
    assert_select "title", "About Student Art ◆ GeoGem"
    assert_select "h2", "About student art - artwork contributed to GeoGem"
    # prof bill email should be in the About Student Art page
    # so thay can send me more/new student art
    assert_select "a[href=?]", "mailto:wtkrieger@noctrl.edu"
  end

  # test About Student Art page details
  test "check about student art page details" do
    get about_student_art_url
    assert_response :success
    assert_select "a", :href => "/login", :text => "Back to Login"
    assert_select "h2", /About student art - */
    # prof bill email should be in the About Student Art page
    # so thay can send me more/new student art
    assert_select "a[href=?]", "mailto:wtkrieger@noctrl.edu"
  end

  # test Help page
  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "Help ◆ GeoGem"
    assert_select "h2", "Help - frequently asked questions about GeoGem"
    # prof bill email should be in the help page, so I can help people (ha!)
    assert_select "a[href=?]", "mailto:wtkrieger@noctrl.edu"
  end

end
