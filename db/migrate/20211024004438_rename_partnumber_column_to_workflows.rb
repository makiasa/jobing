class RenamePartnumberColumnToWorkflows < ActiveRecord::Migration[5.2]
  def change
    rename_column :workflows, :partnumber, :order
  end
end
