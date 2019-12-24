class ChangeColumnToReservations3 < ActiveRecord::Migration[5.0]
  def change
    
     change_column :reservations, :menu_ids, :text, array: true
    
  end
end
