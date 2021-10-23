class AddFirstidToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :firstid, :integer
  end
end
