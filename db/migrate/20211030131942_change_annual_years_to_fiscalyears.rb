class ChangeAnnualYearsToFiscalyears < ActiveRecord::Migration[5.2]
  def change
    rename_table :annual_years, :fiscalyears
  end
end
