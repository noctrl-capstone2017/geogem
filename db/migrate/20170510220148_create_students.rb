class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :full_name
      t.string :screen_name
      t.string :icon
      t.string :color
      t.string :contact_info
      t.text :description
      t.integer :session_interval
      t.integer :school_id

      t.timestamps
    end
  end
end
