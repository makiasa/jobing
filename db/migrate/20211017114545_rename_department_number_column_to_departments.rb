class RenameDepartmentNumberColumnToDepartments < ActiveRecord::Migration[5.2]
  def change
    rename_column :departments, :department_number, :number
  end
end
