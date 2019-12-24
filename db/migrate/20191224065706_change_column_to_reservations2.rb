class ChangeColumnToReservations2 < ActiveRecord::Migration[5.0]
  def change
    
    change_column :reservations, :tel, :string
    
    rename_column :reservations, :menu_id, :menu_ids#, array: true
    
    
  end
end
