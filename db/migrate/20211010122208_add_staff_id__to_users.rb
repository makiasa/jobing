class AddStaffIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :staff_id, :integer
  end
end
