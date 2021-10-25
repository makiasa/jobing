class AddWorkIdToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :work_id, :integer
  end
end
