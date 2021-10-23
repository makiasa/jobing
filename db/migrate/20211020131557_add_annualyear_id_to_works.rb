class AddAnnualyearIdToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :annualyear_id, :integer
  end
end
