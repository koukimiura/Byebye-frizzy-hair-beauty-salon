class ChangeColumnToMenu4 < ActiveRecord::Migration[5.0]
  def up
    change_column :menus, :price, :integer
  end
  
  def down
    change_column :menus, :price, :string
  end
end
