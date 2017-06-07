class AddSuspendedToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :suspended, :boolean, :null => false, :default => false
  end
end
