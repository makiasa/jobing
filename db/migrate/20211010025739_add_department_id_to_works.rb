class AddDepartmentIdToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :department_id, :integer
  end
end
