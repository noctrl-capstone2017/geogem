class AddSessionNotesToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :session_notes, :text
  end
end
