class AddfuriganaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :furigana_firstname, :string
    add_column :users, :furigana_lastname, :string
  end
end
