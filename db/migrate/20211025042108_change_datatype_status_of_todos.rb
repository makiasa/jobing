class ChangeDatatypeStatusOfTodos < ActiveRecord::Migration[5.2]
  def change
    change_column :todos, :status, :integer
  end
end
