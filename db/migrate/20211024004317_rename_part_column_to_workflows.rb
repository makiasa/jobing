class RenamePartColumnToWorkflows < ActiveRecord::Migration[5.2]
  def change
    rename_column :workflows, :part, :content
  end
end
