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
    count = (self.duration / (self.session_interval * 60)).ceil
    count = 1 if count < 1
    count
  end

end
