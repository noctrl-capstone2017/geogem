class RosterSquare < ApplicationRecord
  belongs_to :student, class_name: "Student"
  belongs_to :square, class_name: "Square"
end
