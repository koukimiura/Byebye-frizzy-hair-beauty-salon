class ChangeColumnToReservations < ActiveRecord::Migration[5.0]
  def change
    
    #change_column :reservations, :tel, :integer
    change_column :reservations, :frames, 'text USING CAST(frames AS text)' 

  end
end
