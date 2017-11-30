# Edited by Robert Herrera
require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  # Use the fixtures to set the testing env's school. Teacher is set to super user.
  setup do
    @school = schools(:one)
    log_in_as(teachers(:one))
  end

  # 1) check pulse of all School pages
  test 'check pulse of all school pages' do
    get schools_url   # all schools
    assert_response :success
    assert_select "title", { :count => 1, :text => "All schools ◆ GeoGem" }

    get new_school_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "New school ◆ GeoGem" }

    get edit_school_url(@school)
    assert_response :success
    assert_select "title", { :count => 1, :text => "Edit school ◆ GeoGem" }

    get backup_school_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Backup school ◆ GeoGem" }

    get restore_school_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "Restore school ◆ GeoGem" }

    get suspend_school_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "Suspend school ◆ GeoGem" }
  end

  # 2) check details of Edit School page
  test 'check details of Edit School page' do
    get edit_school_url(@school)
    assert_response :success
    assert_select "h2", /Edit school - */
    assert_select 'form input[type=text][readonly=readonly]#school_full_name'
    assert_select 'form button[type=submit]', { :count => 1, :text => 'Change School' }
  end

  # 3) check details of All Schools page
  test 'check details of All Schools page' do
    get schools_url
    assert_response :success
    assert_select "h2", /All schools - */
    assert_select 'form button[type=submit]'   # new school button
  end

  # 4) check details of New School page
  test 'check details of New School page' do
    get new_school_url
    assert_response :success
    assert_select "h2", /New school - */
    assert_select 'form input[type=text][required=required]#school_full_name'
    assert_select 'form select#school_color'
    assert_select 'form select#school_icon'
    assert_select 'form button[type=submit]'
  end

  # Update to School info is confirmed using a patch req rather than post
  test "should update school" do
    patch school_url(@school), params: { school: { color: @school.color, description: @school.description,
                                                   email: @school.email, full_name: @school.full_name,
                                                   icon: @school.icon, screen_name: @school.screen_name,
                                                   website: @school.website } }
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


#  test "should destroy school" do
#   assert_difference('School.count', -1) do
#     delete school_url(@school)
#    end
#    assert_redirected_to schools_url
#  end

end
