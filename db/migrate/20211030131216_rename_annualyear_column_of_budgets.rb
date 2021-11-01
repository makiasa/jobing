class RenameAnnualyearColumnOfBudgets < ActiveRecord::Migration[5.2]
  def change
    rename_column :budgets, :annualyear, :fiscalyear
  end
end
