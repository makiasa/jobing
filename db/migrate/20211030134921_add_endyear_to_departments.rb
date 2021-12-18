class AddEndyearToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :endyear, :date
  end
end
