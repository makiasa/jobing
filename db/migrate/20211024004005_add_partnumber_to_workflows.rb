class AddPartnumberToWorkflows < ActiveRecord::Migration[5.2]
  def change
    add_column :workflows, :partnumber, :integer
  end
end
