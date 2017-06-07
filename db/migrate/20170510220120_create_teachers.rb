class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.string :user_name
      t.string :password_digest
      t.datetime :last_login
      t.string :full_name
      t.string :screen_name
      t.string :icon
      t.string :color
      t.string :email
      t.text :description
      t.string :powers
      t.integer :school_id

      t.timestamps
    end
  end
end
