# Static Pages Controller Test
# Test for all static pages
# Author: Meagan Moore & Steven Royster & someone else?? Please fill out 
# comments I started for you mystery test writer! Thank you!

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # What this does
  # Author: ??
  test "should get about student art" do
    get about2_url
    assert_response :success
    assert_select "h2", "About student art - artwork contributed to GeoGem"
    #uncomment when pushed
    #assert_select "a[href=mailto:?]",'wtkrieger@noctrl.edu', count: 1
  end

  # What this does
  # Author: ??
  # Fixed by: Meagan Moore & Steven Royster
  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "h2", "Help - frequently asked questions about GeoGem"
  end

  # Tests root path, should be login
  # Author: Meagan Moore & Steven Royster  
  test 'should get root path' do
    get root_path
    assert_response :success
    assert_select "title", "GeoGem"
  end
  
  # Tests the about1 page 
  # Author: Meagan Moore & Steven Royster 
  test "should get about1" do
    get about_url
    assert_response :success
    assert_select "title", "GeoGem"
  end
  
end