require 'test_helper'

# Bill - commented out these test, fix later

class SessionNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session_note = session_notes(:one)
  end

  # test "should get index" do
  #   get session_notes_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_session_note_url
  #   assert_response :success
  # end

  # test "should create session_note" do
  #   assert_difference('SessionNote.count') do
  #     post session_notes_url, params: { session_note: { created_at: @session_note.created_at, note: @session_note.note, session_id: @session_note.session_id } }
  #   end

  #   assert_redirected_to session_note_url(SessionNote.last)
  # end

  # test "should show session_note" do
  #   get session_note_url(@session_note)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_session_note_url(@session_note)
  #   assert_response :success
  # end

  # test "should update session_note" do
  #   patch session_note_url(@session_note), params: { session_note: { created_at: @session_note.created_at, note: @session_note.note, session_id: @session_note.session_id } }
  #   assert_redirected_to session_note_url(@session_note)
  # end

  # test "should destroy session_note" do
  #   assert_difference('SessionNote.count', -1) do
  #     delete session_note_url(@session_note)
  #   end

  #   assert_redirected_to session_notes_url
  # end
end