class CreateAnnualYears < ActiveRecord::Migration[5.2]
  def change
    create_table :annual_years do |t|
      t.integer :year

      t.timestamps
    end
  end
end
