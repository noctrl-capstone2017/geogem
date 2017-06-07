class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :full_name
      t.string :screen_name
      t.string :icon
      t.string :color
      t.string :email
      t.string :website
      t.string :description

      t.timestamps
    end
  end
end
