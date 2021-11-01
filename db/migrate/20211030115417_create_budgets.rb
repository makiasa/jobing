class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.integer :annualyear
      t.integer :subject
      t.integer :amount
      t.integer :department_id

      t.timestamps
    end
  end
end
