class AddStaffNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :staff_number, :integer
  end
end
