class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      
      t.string :name
      #t.string :category
      t.integer :price
      t.string :required_time
      t.string :detail

      t.timestamps
    end
  end
end
