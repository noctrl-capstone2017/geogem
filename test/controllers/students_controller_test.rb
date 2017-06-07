require 'test_helper'

  # authors: Ricky Perez & Michael Loptien
  # Tests for Student Controller

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(teachers(:one))     #Log in a teacher
    @student = students(:one)     #Define a student
  end

# Pull up index screen, requires an Adim to be signed in
  test "should get index" do
    get students_url
    assert_response :success
  end

# Pull up the new student screen
  test "should get new" do
    get new_student_url
    assert_response :success
  end

# Add a student with the supplied attributes
  test "should create student" do
        assert_difference('Student.count') do
          post students_url, params: { student: { color: "red", school_id: "1", 
          contact_info: "hey", 
          description: "Hey", 
          icon: "bug", screen_name: "hey", 
          full_name: "James S",
          session_interval: 5} }
    end
    assert_redirected_to students_url
  end

# Try to add a student but should fail - missing required info
  test "should not create student. Empty name." do
    assert_no_difference('Student.count') do
      post students_url, params: { student: { color: "red", school_id: "1", 
      contact_info: "hey", 
      description: "Hey", 
      icon: "bug", screen_name: "hey", 
      full_name: ""} }
    end
  end
  
# Should open the edit view for a student
  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

# Should properly update a student
  test "should update student" do
    patch student_url(@student), params: { student: { color: "red",
      school_id: "1", 
      contact_info: "hey", 
      description: "Hey", 
      icon: "bug", screen_name: "hey", 
      full_name: "James L"} }
      assert_redirected_to students_url
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
