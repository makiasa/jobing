class AddAdoptDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :adopt_date, :date
    add_column :users, :retire_date, :date
  end
end
