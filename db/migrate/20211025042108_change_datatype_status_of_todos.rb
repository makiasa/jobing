class ChangeDatatypeStatusOfTodos < ActiveRecord::Migration[5.2]
  def change
    change_column :todos, :status, :integer, using: 'status::integer'
  end
end
