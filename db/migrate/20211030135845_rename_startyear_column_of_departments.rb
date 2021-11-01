class RenameStartyearColumnOfDepartments < ActiveRecord::Migration[5.2]
  def change
    rename_column :departments, :startyear, :startdate
  end
end
