class CreateRosterSquares < ActiveRecord::Migration[5.0]
  def change
    create_table :roster_squares do |t|
      t.integer :square_id
      t.integer :student_id

      t.timestamps
    end
  end
end
