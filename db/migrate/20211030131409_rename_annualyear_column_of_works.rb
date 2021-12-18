class RenameAnnualyearColumnOfWorks < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :annualyear, :fiscalyear
  end
end
