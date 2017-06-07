class CreateSessionEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :session_events do |t|
      t.integer :behavior_square_id
      t.datetime :square_press_time
      t.datetime :duration_end_time
      t.integer :session_id

      t.timestamps
    end
  end
end
