class RenameAnnualyearIdColumnOfWorks < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :annualyear_id, :annualyear
  end
end
