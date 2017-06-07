require 'test_helper'

class SessionNoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @session = sessions(:one)
    #@session_note = @session.session_notes.build(note: "Lorem ipsum")
    @session_note = SessionNote.new(note: "Lorem ipsum", session_id: @session.id)
  end
  
  test "should be valid" do
    assert @session_note.valid?
  end
  
  test "session id should be present" do
    @session_note.session_id = nil
    assert_not @session_note.valid?
  end
  
  test "content should be present" do
    @session_note.note = "   "
    assert_not @session_note.valid?
  end
  
  test "order should be most recent first" do
    assert_equal session_notes(:tau_manifesto), SessionNote.first
  end
  
  ##test "associated notes should be destroyed" do
    #@session.save
    ##@session.session_notes.create!(note: "Lorem ipsum")
    #assert_difference 'SessionNote.count', -1 do
     # @session.destroy
    ##nd
  #end  
end