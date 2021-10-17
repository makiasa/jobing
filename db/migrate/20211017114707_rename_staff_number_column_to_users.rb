class RenameStaffNumberColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :staff_number, :number
  end
end
