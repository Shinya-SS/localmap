class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduction, :string
    add_column :users, :icon, :string
  end
end
