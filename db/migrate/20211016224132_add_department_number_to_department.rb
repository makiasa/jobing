class AddDepartmentNumberToDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :department_number, :integer
  end
end
