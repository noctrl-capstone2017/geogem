class FixStudentColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :students, :interval_counting, :session_interval_counting
    rename_column :students, :session_notes, :session_instructions
  end
end
