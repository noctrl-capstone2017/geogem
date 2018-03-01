#author Matthew O & Alex P
class Session < ApplicationRecord
  has_many :session_events , dependent: :destroy
  has_many :session_notes

  # returns school ID for a session; it's defined be the session student
  def school_id
    student = Student.find( self.session_student)
    student.school_id
  end

end
