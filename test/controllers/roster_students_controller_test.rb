# Kevin M:
# Just a scaffolding test.
require 'test_helper'

class RosterStudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roster_student = roster_students(:one)
  end
  
  #Basic scaffolding test.
  test "should update roster_student" do
    patch roster_student_url(@roster_student), params: { roster_student: { student_id: @roster_student.student_id, teacher_id: @roster_student.teacher_id } }
  end
end
