# Edited by Robert Herrera
require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  # Use the fixtures to set the testing env's school. Teacher is set to super user.
  setup do
    @school = schools(:one)
    log_in_as(teachers(:one))
  end
  
  # Asserts pages are reached once logged in as super user
  test "should get index" do
    get schools_url
    assert_response :success
  end

  test "should get new" do
    get new_school_url
    assert_response :success
  end
  
  # A difference in the number of schools asserts that a School is created
#  test "should create school" do
#    assert_difference('School.count') do
#      post schools_url, params: { school: { color: @school.color, description: @school.description,
#                                            email: @school.email, full_name: @school.full_name,
#                                            icon: @school.icon, screen_name: @school.screen_name,
#                                            website: @school.website } }
#    end
    # User is redirected after creating a School
#    assert_redirected_to school_url(School.last)
#  end

  test "should show school" do
    get school_url(@school)
    assert_response :success
  end

  test "should get edit" do
    get edit_school_url(@school)
    assert_response :success
  end
  
  # Update to School info is confirmed using a patch req rather than post
  test "should update school" do
    patch school_url(@school), params: { school: { color: @school.color, description: @school.description,
                                                   email: @school.email, full_name: @school.full_name,
                                                   icon: @school.icon, screen_name: @school.screen_name,
                                                   website: @school.website } }

  end

#  test "should destroy school" do
#   assert_difference('School.count', -1) do
#     delete school_url(@school)
#    end
#    assert_redirected_to schools_url
#  end
  
end #end of schools_controller_test.rb file
