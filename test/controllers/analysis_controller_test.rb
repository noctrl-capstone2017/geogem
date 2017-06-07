# Author: Carolyn C
#Purpose: Tests the analysis pages
require 'test_helper'
class AnalysisControllerTest < ActionDispatch::IntegrationTest
    
    #Sets up the student as first student, and user as first teacher.
    setup do
        @student = students(:one)
        @user = teachers(:one)
        @session = sessions(:one)
    end
    
    #allow student ID to be available on analysis
    test "get student ID" do
        log_in_as(@user)
        get @student.id
        assert_response :success
    end
    
    #makes sure the student has an ID
    test "student must have ID" do
        assert_not_nil( @student.id, "Student doesn't have id")	
    end
    
    #make sure the session is attatched to the student
    test "Session with Student" do
        assert_not_nil( @session.session_student, "Session not attatched to student")	
    end
    
    #make sure sessions are available from the page
    test "get sessions" do
        get @sessions
        assert_response :success
    end
    
    #make sure user id is not null
    test "user must have id" do
       assert_not_nil( @user.id, "User doesn't have ID")
    end
    
end