class AddEndyearToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :endyear, :integer
  end
end
