module StudentsHelper

  # return a ux/view string for the last session data of a student
  # sessions - a list of sessions, presumably controller prepared 
  # student - the student
  def ux_last_session_date( sessions, student)
    this_session = sessions.where(session_student: student.id).last
    if this_session && this_session.end_time
      this_session.end_time.strftime("%a %b %d, %Y")
    else
      "No previous session"
    end
  end

  # returns the formatter date of a session used in reports: Tue Feb 27, 2018
  def ux_session_date( session)
    session ? session.start_time.strftime("%a %b %d, %Y") : ""
  end

  # returns the student instructions for a session, set to "none" if empty
  def ux_session_instructions( student)
    student.session_instructions.blank? ? "None" : student.session_instructions
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

  # Topaz form - returns a string that serves as the interval time range
  # For example: 8:00-9:00
  def ux_topaz_time_range( student, interval_num)
    # multiplier is minutes per interval
    multiplier = student.session_interval

    start_time = Time.parse( '8:00') + (interval_num-1) * multiplier.minutes
    end_time = start_time + multiplier.minutes

    # nicely formatted return string, for example 8:00-9:00
    if student.session_interval == 5
      start_time.strftime( ':%M') << " - " << end_time.strftime( ':%M')
    else
      start_time.strftime( '%-l:%M') << "-" << end_time.strftime( '%-l:%M')
    end
  end

  # this is a jumble
  def ux_ruby_count_events_during_interval( sesh, events, square, cur_interval)
    e = events.where( behavior_square_id: square.id, interval_num: cur_interval)
    if sesh.session_interval_counting
      (e.count > 0) ? "\u2713" : " "
    else
      e.count
    end
  end

  # Ruby Report - returns a string that serves as the interval time range
  # For example: 11:00 - 11:05
  def ux_ruby_time_range( session, interval_num)
    # multiplier is minutes per interval
    multiplier = session.session_interval

    # calc the start and end times of the range
    start_time = session.start_time + (interval_num * multiplier.minutes)
    end_time = start_time + multiplier.minutes

    # format the strings using Central Time
    start_string = start_time.in_time_zone('Central Time (US & Canada)').strftime("%-l:%M")
    end_string = end_time.in_time_zone('Central Time (US & Canada)').strftime("%-l:%M")
    start_string << " - " << end_string
  end

end
