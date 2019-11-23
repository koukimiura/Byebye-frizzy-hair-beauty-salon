class ChangeColumnToMenu3 < ActiveRecord::Migration[5.0]
  
    def up
      change_column :menus, :category, :integer
    end
  
    def down
      change_column :menus, :category, :string
    end
    

end
