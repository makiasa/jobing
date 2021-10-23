class RenameFirstworkidColumnToWorks < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :firstworkid, :firstid
  end
end
