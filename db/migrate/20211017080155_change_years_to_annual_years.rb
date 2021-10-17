class ChangeYearsToAnnualYears < ActiveRecord::Migration[5.2]
  def change
    rename_table :years, :annual_years
  end
end
