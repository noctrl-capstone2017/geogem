class AddCurLoginToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :cur_login, :datetime
  end
end
