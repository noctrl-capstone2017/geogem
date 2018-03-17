# Authors Alexander Pavia + Matthew O + Debra J
module SessionsHelper

  # if interval square pressed show "yes" in end session report, else return "no"
  def getInterval(square)
    @session = Session.find(params[:id])
    @student = Student.find(@session.session_student)
    @sessionEvent = SessionEvent.where(session_id: @session.id, behavior_square_id: square.id)
    answer = "No"

    if  @sessionEvent.length >= 1
      #behavior happend 
      return answer = "Yes"
    end
    
    return answer
  end # end isInterval

  # Authors Alexander Pavia + Matthew O + Debra J
  #display the frequency on the end session summary report
  def getFrequency(square)
    @session = Session.find(params[:id])
    
    # total number of session events for a square 
    @frequency = SessionEvent.where(session_id: @session.id, behavior_square_id: square.id).count
  
    return @frequency
  end # end isFrequency
  
  #Authors Alex P + Matthew O + Debra J
  #gets the duration and display on the end session summary report
  def getDuration(square)
   
    @session = Session.find(params[:id])
    @sessionEvent = SessionEvent.where(session_id: @session.id, behavior_square_id: square.id)
   
    #total duration for the square
    totalDuration = 0
    
    #get the session Events for the square
    @sessionEvent.each do |event|
     start = Time.at(event.square_press_time)
     endt = Time.at(event.duration_end_time)
     eventDuration= endt - start
     totalDuration += eventDuration 
    end
   
    return totalDuration
  end

  # returns the duration (num seconds) in a nicely formatted string
  def formatTime(duration)
    # format duration as appropriate: in seconds, minutes or hours
    if duration >= 3600
      # session lasted more than 1 hour=3600 seconds; use hours/minutes
      Time.at(duration).utc.strftime("%-H hours, %-M minutes") 
    elsif duration >= 60
      # session lasted more than 1 minute=60 seconds; use minutes
      Time.at(duration).utc.strftime("%-M minutes") 
    else
      # session lasted less than 1 minute; use seconds
      Time.at(duration).utc.strftime("%-S seconds")
    end
  end

  # return session start time, nicely formatted
  def ux_session_start_time( session, show_time_zone=false) 
    if show_time_zone
      session.start_time.in_time_zone('Central Time (US & Canada)').strftime("%-l:%M %P (%Z)")
    else
      session.start_time.in_time_zone('Central Time (US & Canada)').strftime("%-l:%M %P")
    end
  end

  # return session end time, nicely formatted
  def ux_session_end_time( session, show_time_zone=false)
    if session.end_time != nil
      if show_time_zone
        session.end_time.in_time_zone('Central Time (US & Canada)').strftime("%-l:%M %P (%Z)")
      else
        session.end_time.in_time_zone('Central Time (US & Canada)').strftime("%-l:%M %P")
      end
    else
      "error"
    end
  end

  # return session time range: start - end times
  def ux_session_time_range( session)
    ux_session_start_time( session) + " - " + ux_session_end_time( session)
  end

  # calculates session duration and returns it, nicely formatted
  def ux_session_duration(session)
    return formatTime( session.duration)
  end

  # returns the start date in a nice format
  def ux_session_start_date( session)
    session.start_time.in_time_zone('Central Time (US & Canada)').strftime("%a %b %d, %Y")
  end

  # returns the name of the teacher for this behavior session
  def ux_session_teacher_name( session) 
    teacher = Teacher.find( session.session_teacher)
    teacher.full_name
  end

  # returns the name of the student for this behavior session
  def ux_session_student_name( session) 
    student = Student.find( session.session_student)
    student.full_name
  end

  # return a string describing the counting style of this session
  def ux_session_counting_style( session) 
    if session.session_interval_counting
      "Interval counting, once per interval"
    else
      "Default, each square press counted"
    end
  end

  # returns the database ID of the session, hopefully this is only used by Super
  def ux_session_id( session)
    session.id
  end

  # returns a checkmark ✔ if session is certififed OK
  def ux_session_certified( session) 
    if session.certified
      "\u2713"      # unicode for checkmark, it's certified!
    else
      "\u274C"      # unicode for ugly X crossmark, it's NOT certified (bad)
    end
  end

end
