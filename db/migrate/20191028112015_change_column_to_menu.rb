class ChangeColumnToMenu < ActiveRecord::Migration[5.0]
  def up
    change_column :menus, :required_time, :string
  end
  
  def down
    change_column :menus, :required_time, :integer
  end
end
