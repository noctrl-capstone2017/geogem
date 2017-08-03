# author: Kevin M, Tommy B
# Teacher controller testing.

require 'test_helper'

class TeachersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)
  end

  # This section tests for the correct links to other pages
  #Authors: Alex P Debra J Matthew O
  # test the home screen
  test "should get home" do
    log_in_as(@teacher)
    get "/home"
    assert_response :success
 end

  test "should get new" do
    log_in_as(@teacher)
    get new_teacher_url
    assert_response :success
  end

  test "should show teacher" do
    log_in_as(@teacher)
    get teacher_url(@teacher)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@teacher)
    get edit_teacher_url(@teacher)
    assert_response :success
  end

  # End of testing links
  
  # Tests loading of the teacher's data when editing a teacher
  test "should properly load existing info when loading a profile" do
    log_in_as(@teacher)
    get edit_teacher_url(@teacher)
    assert_template "teachers/edit"
    #This is all that's necessary, since if one part of it fails, all of it does.
    assert_select 'h2', text: "Edit teacher - Admin page 1; edit attributes of teacher, #{@teacher.full_name}"
  end
  
  # Steven Royster
  # Inspired by previous capstone class
  test "should show superadmin" do
    log_in_as(teachers(:one))
    get teacher_url(@teacher)
    assert_response :success
  end
end
