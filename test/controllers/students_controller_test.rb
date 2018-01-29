require 'test_helper'

  # authors: Ricky Perez & Michael Loptien
  # Tests for Student Controller

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(teachers(:one))     #Log in a teacher
    @student = students(:one)     #Define a student
  end

  # 1) check pulse - existence + pulse
  test 'check pulse of all student pages' do
    get students_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "All students ◆ GeoGem" }

    get new_student_url
    assert_response :success
    assert_select "title", { :count => 1, :text => "New student ◆ GeoGem" }

    get student_url(@student)
    assert_response :success
    assert_select "title", { :count => 1, :text => "Student page ◆ GeoGem" }

    get edit_student_path(@student)
    assert_response :success
    assert_select "title", { :count => 1, :text => "Setup student ◆ GeoGem" }

    get editb_student_path(@student)
    assert_response :success
    assert_select "title", { :count => 1, :text => "Assign squares ◆ GeoGem" }
  end

  # Add a student with the supplied attributes
  test "should create student" do
    assert_difference('Student.count') do
      post students_url, params: { 
        student: { color: "red", school_id: "1", 
          contact_info: "hey", 
          description: "Hey", 
          icon: "bug", screen_name: "hey", 
          full_name: "James S",
          session_interval: 5}
      }
    end
    assert_redirected_to students_url
  end

  # Try to add a student but should fail - missing required info
  test "should not create student. Empty name." do
    assert_no_difference('Student.count') do
      post students_url, params: { 
        student: { color: "red", school_id: "1", 
          contact_info: "hey", 
          description: "Hey", 
          icon: "bug", screen_name: "hey", 
          full_name: ""} 
      }
    end
  end

  # Should properly update a student
  test "should update student" do
    patch student_url(@student), params: { student: { color: "red",
      school_id: "1", 
      contact_info: "hey", 
      description: "Hey", 
      icon: "bug", screen_name: "hey", 
      full_name: "James L"} }
      # changed this, stays on the page now
      #assert_redirected_to students_url
  end

# Should not update a student - missing required info
  test "should not update student. Empty name." do
    patch student_url(@student), params: { student: { color: "red",
      school_id: "1", 
      contact_info: "hey", 
      description: "Hey", 
      icon: "bug", screen_name: "hey", 
      full_name: ""} }
  end

end
