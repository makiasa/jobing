class AddTaskToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :task, :text
  end
end
