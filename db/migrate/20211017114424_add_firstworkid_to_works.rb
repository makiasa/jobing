class AddFirstworkidToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :firstworkid, :integer
  end
end
