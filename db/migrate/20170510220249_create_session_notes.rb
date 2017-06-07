class CreateSessionNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :session_notes do |t|
      t.text :note
      t.integer :session_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
