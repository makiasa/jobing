class ChangeDatatypeEnddateOfDepartments < ActiveRecord::Migration[5.2]
  def change
    change_column :departments, :enddate, :date
  end
end
