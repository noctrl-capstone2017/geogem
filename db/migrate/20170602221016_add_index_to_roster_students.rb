class AddIndexToRosterStudents < ActiveRecord::Migration[5.0]
  def change
    add_index :roster_students, [:student_id, :teacher_id], unique: true
  end
end
