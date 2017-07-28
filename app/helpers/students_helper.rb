module StudentsHelper

  # return a ux/view string for the last session data of a student
  # sessions - a list of sessions, presumably controller prepared 
  # student - the student
  def ux_last_session_date( sessions, student)
    this_session = sessions.where(session_student: student.id).last
    if this_session
      this_session.end_time.strftime("%a %b %d, %Y")
    else
      "No previous session"
    end
  end

  # returns a ux/view string for num behavior sessions for student
  # sessions - a list of sessions, presumably controller prepared
  # student - the student
  def ux_num_sessions( sessions, student)
    student_sessions = sessions.where(session_student: student.id)
    student_sessions ? student_sessions.size : 0
  end

  # returns ux string for student's name
  def ux_student_name( student, num_chars=20)
    num_chars > 0 ? student.full_name.truncate( num_chars) : student.full_name
  end
end
