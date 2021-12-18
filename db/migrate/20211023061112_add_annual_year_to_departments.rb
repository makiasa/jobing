class AddAnnualYearToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :annual_year, :date
  end
end
