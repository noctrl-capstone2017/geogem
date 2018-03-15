#Authors: Alex P Debra J Matthew O
require 'test_helper'

class SessionEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session = sessions(:one)
    @session_event = session_events(:one)
    @user = teachers(:one)
  end

  #Authors: Alex P Debra J Matthew O
  #makes sure session event is created
  test "should create session_event" do
    log_in_as(@user)
    assert_difference('SessionEvent.count') do
      post session_events_url, params: { 
            behavior_id: @session_event.behavior_square_id, 
            end_time: @session_event.duration_end_time, 
            session_id: @session_event.session_id,
            start_time: @session_event.square_press_time,
            interval_num: 0 } 
    end
  end

end
