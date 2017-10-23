require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session = sessions(:one)
    @user = teachers(:one)
  end

  test "should get index" do
    log_in_as(@user)
    get sessions_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_session_url
    assert_response :success
  end
  
  #Authors: Alex P Debra J Matthew O
  #makes sure session can be created after logging in
  test "should create session" do
    log_in_as(@user)
    assert_difference('Session.count') do
      post sessions_url, params: { session: { end_time: @session.end_time, session_student: @session.session_student, session_teacher: @session.session_teacher, start_time: @session.start_time } }
    end

    assert_redirected_to session_url(Session.last)
  end
  
  #Authors: Alex P Debra J Matthew O
  #ensure that a session has a teacher assigned to it
  test "session must have a teacher" do
    assert_not_nil( @session.session_teacher, "session doesn't have teacher")	
  end
  
  #Authors: Alex P Debra J Matthew O
  #ensure that a session has a student assigned to it
  test "session must have a student" do
    assert_not_nil( @session.session_student, "session doesn't have student")	
  end
  
  #Authors: Alex P Debra J Matthew O
  #ensure that a session's start time is less than the end time, 
  #valid sessions should last at least a few seconds
  test "start time is less than end time" do
    assert(@session.start_time < @session.end_time, "start time is greater than end time")
  end
  
  #Authors: Alex P Debra J Matthew O
  #get the show screen 
  test "should show session" do
    log_in_as(@user)
    get end_session_url(@session)
    assert_response :success
  end
  
  #Authors: Alex P Debra J Matthew O
  #get the end screen 
  test "should show end" do
    log_in_as(@user)
    post end_session_url(@session)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_session_url(@session)
    assert_response :success
  end
  
  #Authors: Alex P Debra J Matthew O
  #makes sure session can be updated after logging in
  test "should update session" do
    log_in_as(@user)
    patch session_url(@session), params: { session: { end_time: @session.end_time, session_student: @session.session_student, session_teacher: @session.session_teacher, start_time: @session.start_time } }
    assert_redirected_to session_url(@session)
  end

  test "should destroy session" do
    log_in_as(@user)
    assert_difference('Session.count', -1) do
      delete session_url(@session)
    end
    assert_redirected_to sessions_url
  end
end
