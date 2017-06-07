class ChangeColumnDefaultSessionInterval < ActiveRecord::Migration[5.0]
  def change
    change_column :students, :session_interval, :integer, :default => 15
  end
end
