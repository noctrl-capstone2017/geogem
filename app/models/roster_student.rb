# Kevin M:
# Defines the relationship between teacher and student.
class RosterStudent < ApplicationRecord
  belongs_to :teacher, class_name: "Teacher"
  belongs_to :student, class_name: "Student"
end
