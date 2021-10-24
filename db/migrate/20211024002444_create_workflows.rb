class CreateWorkflows < ActiveRecord::Migration[5.2]
  def change
    create_table :workflows do |t|
      t.integer :work_id
      t.text :part
      t.text :note
      t.string :filepath

      t.timestamps
    end
  end
end
