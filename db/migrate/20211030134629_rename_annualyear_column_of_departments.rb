class RenameAnnualyearColumnOfDepartments < ActiveRecord::Migration[5.2]
  def change
    rename_column :departments, :annual_year, :startyear
  end
end
