class CreateSquares < ActiveRecord::Migration[5.0]
  def change
    create_table :squares do |t|
      t.string :full_name
      t.string :screen_name
      t.string :color
      t.integer :type
      t.text :description
      t.integer :school_id

      t.timestamps
    end
  end
end
