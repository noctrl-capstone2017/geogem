module SessionNotesHelper

  # return a nicely-formatted string for the session note time
  def ux_session_note_time( note)
    note.created_at.in_time_zone('Central Time (US & Canada)').strftime("%l:%M %P")
  end

end
