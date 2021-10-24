class ChangeDatatypeFilepathOfWorkflows < ActiveRecord::Migration[5.2]
  def change
    change_column :workflows, :filepath, :text
  end
end
