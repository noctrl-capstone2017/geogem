class AddAccessAllStudentsToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :access_all_students, :boolean, default: true
  end
end
