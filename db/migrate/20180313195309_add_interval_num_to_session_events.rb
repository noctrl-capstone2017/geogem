class AddIntervalNumToSessionEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :session_events, :interval_num, :integer
  end
end
