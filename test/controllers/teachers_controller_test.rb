# author: Kevin M, Tommy B
# Teacher controller testing.

require 'test_helper'

class TeachersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)
  end

  # 1) check pulse - existence + title
  test 'check pulse of all teacher pages' do
    log_in_as(@teacher)

    get home_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Home ◆ GeoGem" }
    
    get profile_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Profile ◆ GeoGem" }
    
    get password_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Change password ◆ GeoGem" }

    get admin_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Admin dashboard ◆ GeoGem" }
    
    get admin_report_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Admin report ◆ GeoGem" }
    
    get super_path
    assert_response :success
    assert_select "title", { :count => 1, :text => "Super dashboard ◆ GeoGem" }

    get teachers_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "All teachers ◆ GeoGem" }

    get new_teacher_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "New teacher ◆ GeoGem" }

    get edit_teacher_url(@teacher)
    assert_response :success
    assert_select "title", { :count => 1, :text => "Edit teacher ◆ GeoGem" }

    get edit2_teacher_url(@teacher)
    assert_response :success
    assert_select "title", { :count => 1, :text => "Login settings ◆ GeoGem" }

    get edit3_teacher_url(@teacher)
    assert_response :success
    assert_select "title", { :count => 1, :text => "Teacher access ◆ GeoGem" }
  end

  # 2) check details of Home page
  test 'check details of Home page' do
    log_in_as(@teacher)
    get home_path
    assert_response :success
    assert_select "h2", /Home - */
    # there are 2 Go Student buttons, one is always hidden
    assert_select 'form button[type=submit][name=go_student]', { :count => 2 }
  end

  # 3) check details of Profile page
  test 'check details of Profile page' do
    log_in_as(@teacher)
    get profile_path
    assert_response :success
    assert_select "h2", /Profile - */
    assert_select 'form input[type=text][readonly=readonly]#usernameField'
    assert_select 'form input[type=text][readonly=readonly]#nameField'
    assert_select 'form button[type=submit]', { :count => 1, :text => 'Change Profile' }
    assert_select 'a[href="password"]'
  end

  # 4) check details of Password page
  test 'check details of Password page' do
    log_in_as(@teacher)
    get password_path
    assert_response :success
    assert_select "h2", /Change password - */
    assert_select 'form input[type=password][required=required]', { :count => 3 }
    assert_select 'form input#teacher_current_password'
    assert_select 'form input#teacher_password'
    assert_select 'form input#teacher_password_confirmation'
    assert_select 'form button[type=submit]', { :count => 1, :text => 'Change Password' }
  end

  # 5) check details of Admin page
  test 'check details of Admin page' do
    log_in_as(@teacher)
    get admin_path
    assert_response :success
    assert_select "h2", /Admin dashboard - */
    assert_select 'a[href="/students"]'
    assert_select 'a[href="/teachers"]'
    assert_select 'a[href="/squares"]'
    assert_select 'a[href="/schools/1/edit"]'
    assert_select 'a[href="/admin_report"]'
  end

  # 6) check details of Admin Report page
  test 'check details of Admin Report page' do
    log_in_as(@teacher)
    get admin_report_path
    assert_response :success
    assert_select "h2", /Admin report - */
    assert_select '#headingStudents'
    assert_select '#collapseStudents'
    assert_select '#headingTeachers'
    assert_select '#collapseTeachers'
    assert_select '#headingSquares'
    assert_select '#collapseSquares'
  end

  # 7) check details of Super Dashboard page
  test 'check details of Super Dashboard page' do
    log_in_as(@teacher)
    get super_path
    assert_response :success
    assert_select "h2", /Super dashboard - */
    assert_select 'a[href="/schools"]'
  end

  # 8) check details of Super Report page
  test 'check details of Super Report page' do
    log_in_as(@teacher)
    get super_report_path
    assert_response :success
    assert_select "h2", /Super report - */
  end

  #
  # 9) check that pages require login - redirected to Login if not valid user
  #
  test 'check login for most pages' do
    get home_path
    assert_response :redirect
    get profile_path
    assert_response :redirect
    get password_path
    assert_response :redirect
    get admin_path
    assert_response :redirect
    get admin_report_path
    assert_response :redirect
  end


  # older tests
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
    assert_select 'h2', text: "Edit teacher - edit attributes of teacher, #{@teacher.full_name}"
  end
  
  # Steven Royster
  # Inspired by previous capstone class
  test "should show superadmin" do
    log_in_as(teachers(:one))
    get teacher_url(@teacher)
    assert_response :success
  end

end
