class AddIntervalCountingToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :interval_counting, :boolean
  end
end
