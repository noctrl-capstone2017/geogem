class AddCertifiedToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :certified, :boolean, default: false
  end
end
