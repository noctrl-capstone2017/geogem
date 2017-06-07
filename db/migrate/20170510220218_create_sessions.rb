class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :session_teacher
      t.integer :session_student

      t.timestamps
    end
  end
end
