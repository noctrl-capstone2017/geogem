# Author: Meagan Moore & Steven Royster & someone else??
require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @teacher = teachers(:one)
  end

  # test the root path, should be login
  test 'should get root path' do
    get root_path
    assert_response :success
    assert_select "title", "Login ◆ GeoGem"
  end

  # test About page 
  test "should get about1" do
    get about_url
    assert_response :success
    assert_select "title", "About ◆ GeoGem"
  end

  # test About Student Art page
  test "should get about student art" do
    get about2_url
    assert_response :success
    assert_select "h2", "About student art - artwork contributed to GeoGem"
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
