class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :name
      t.text :summary
      t.integer :period

      t.timestamps
    end
  end
end