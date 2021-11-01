class RenameEndyearColumnOfDepartments < ActiveRecord::Migration[5.2]
  def change
    rename_column :departments, :endyear, :enddate
  end
end
