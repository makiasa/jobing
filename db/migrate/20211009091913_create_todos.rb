class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.date :deadline
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end