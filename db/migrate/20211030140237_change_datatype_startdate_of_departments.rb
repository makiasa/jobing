class ChangeDatatypeStartdateOfDepartments < ActiveRecord::Migration[5.2]
  def change
    change_column :departments, :startdate, :date
  end
end
