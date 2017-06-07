#Author: Kevin Portland
require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  def setup
    @timmy = Student.new(id: 1)
    @testSess = Session.new(id:1)
  end
  
  #makes sure a session can be resolved to a student
  test "session belongs to student" do 
    timmySess = Session.new(session_student:1) #structure not idiomatic =(
    assert_same(timmySess.session_student,@timmy.id)
  end
  #makes sure a session_event can be resolved to a session
  test "session_event belongs to session" do
    testEvent = SessionEvent.new(session_id:1)
    assert_same(testEvent.session_id,@testSess.id)
  end
  #ideally would test session requiring a student and session_event requiring a session, but they don't.
end
