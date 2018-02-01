class AddSessionIntervalToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :session_interval, :integer
    add_column :sessions, :session_interval_counting, :boolean
    add_column :sessions, :session_instructions, :text
  end
end
