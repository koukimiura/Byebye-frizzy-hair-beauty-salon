class ChangeColumnToReservations3 < ActiveRecord::Migration[5.0]
  def change
    
     change_column :reservations, :menu_ids, 'text USING CAST(menu_ids AS text)'  #, array: true
    
  end
end
