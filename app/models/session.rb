#author Matthew O & Alex P
class Session < ApplicationRecord
  has_many :session_events , dependent: :destroy
  has_many :session_notes

  # returns school ID for a session; it's defined be the session student
  def school_id
    student = Student.find( self.session_student)
    student.school_id
  end

  # returns the session duration (end time - start time) in seconds
  def duration
    self.end_time.to_i - self.start_time.to_i
  end

  # returns the number of intervals in the session, given its duration (in secs)
  # and the size of each interval (in mins)
  def num_intervals
    count = (self.duration.to_f / (self.session_interval * 60)).ceil
    count = 1 if count < 1      # sanity check
    count
  end

  # Certify that this session is OK before using it. Certification covers 2 things.
  # 1) Fix old sessions where the data model has changed (example: session_interval), and
  # 2) Fix sessions that don't have an end_time because it wasn't ended properly.
  def certify
    return if self.certified

    # Step 1 - if no session interval, then use the student's
    if session_interval.nil? ||  session_instructions.nil?  ||  session_interval_counting.nil?
      fix_student_attributes
    end

    # Step 2 - if no end_time, then assign one using the events in the session
    if end_time.nil?
      fix_session_end_time
    end

    # Step 3 - certify that all events have an interval_num, added in V0.5
    @events = SessionEvent.where( session_id: self)
    @events.each do | each_event | 
      if each_event.interval_num.nil?
        each_event.set_interval_num( self)
        each_event.save
      end
    end

    # Step 4- mark this session as ceritifed and save it
    self.certified = true
    self.save
  end

  private

    # A session inherits some important attributes from the student.
    # Some sessions were created before this change was made.
    # This method fixes this by copying the student's attributes now.
    # This may have changed since the session, but it's the best we can do.
    def fix_student_attributes
      change_flag = false

      # Inherit the student's attribute values
      stu = Student.find( self.session_student)
  
      if self.session_interval.nil?
        self.session_interval = stu.session_interval
        change_flag = true
      end

      if self.session_instructions.nil?
        self.session_instructions = stu.session_instructions
        change_flag = true
      end

      if self.session_interval_counting.nil?
        self.session_interval_counting = stu.session_interval_counting
        change_flag = true
      end

      if change_flag
        self.save
      end
    end

    # Fixes the end_time for a session.
    # This can happen when the behavior session page is interrupted.
    # I use the time of the last session event. If there are no events (ugh),
    # then I just use the start_time of the session + 1 minute.
    def fix_session_end_time

      # 1 - get the time of the last event in the session
      the_time = nil
      events = SessionEvent.where( :session_id => self.id)
      if events.present?
        last_event = events.last
        the_time = last_event.duration_end_time
        the_time = last_event.square_press_time if the_time.nil?
      end
  
      # 2 - if that failed, then use the start time of the session + 1 minute.
      # Crikey. Any better ideas?
      if the_time.nil?
        the_time = self.start_time + 1.minutes
      end
  
      # 3) we've got our time, so set it in the session and save
      self.end_time = the_time
      self.save
    end

end
