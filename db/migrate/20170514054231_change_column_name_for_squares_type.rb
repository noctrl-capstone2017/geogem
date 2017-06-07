class ChangeColumnNameForSquaresType < ActiveRecord::Migration[5.0]
  def change
    rename_column :squares, :type, :tracking_type
  end
end
