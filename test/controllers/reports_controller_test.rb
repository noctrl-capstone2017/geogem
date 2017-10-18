# Author: Nate V, Taylor S
# Reports Testing File
require 'test_helper'
require 'login_session_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  
  #Taylor S
  #Setup the teacher, student, and session for the report
  def setup
    @teacher = teachers(:one)
    @teacher2 = teachers(:two)
    @student = students(:one)
    @session = sessions(:one)
    @session2 = sessions(:two)
    @session_event = session_events(:one)
  end
  
  
  #TS
  #Checks to see if a logged out user gets redirected when
  #trying to access /report1
  # test "must be logged in" do
  #   post report1_url, params: {id: @session.id}
  #   assert_response :redirect #should get redirected because not logged in
  # end
  
  #TS
  #Checks to see if a logged in teacher can get the report
  # test "should_get_report" do
  #   log_in_as(@teacher)
  #   #send in the id for the session of interest
  #   post report1_url, params: {id: @session.id}
  #   assert_response :success
  # end
  
  
  #TS
  #Checks to see if a logged in teacher can get the report
  # test "should_get_report_for_second_session" do
  #   log_in_as(@teacher)
  #   #send in the id for the session of interest
  #   post report1_url, params: {id: @session2.id}
  #   assert_response :success
  # end
  
  
  #TS
  #I couldn't think of many test ideas, so I tested the fixutres to
  #make sure they were working properly
  
  test "teacher1_should_not_be_nil" do
  assert_not_nil(@teacher, "Teacher1 fixture is nil")
  end
  
  test "teacher2_should_not_be_nil" do
  assert_not_nil(@teacher2, "Teacher1 fixture is nil")
  end
  
  #TS
  test "student1_should_not_be_nil" do
  assert_not_nil(@student, "Student1 fixture is nil") 
  end
  
  #TS
  test "session1_should_not_be_nil" do
  assert_not_nil(@session, "Session1 fixture is nil") 
  end
  
  #TS
  test "session1_should_have_session_events" do
  assert_not_nil(Session.where(student_id: @student.id), "Session1 fixture has no session events")  
  end
  
end