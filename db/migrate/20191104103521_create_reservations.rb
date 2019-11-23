class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|

      t.integer :staff_id
      t.integer :menu_id
      t.string :date
      t.string :frames
      t.string :last_name
      t.string :first_name
      t.string :last_name_kana
      t.string :first_name_kana
      t.string :tel
      t.string :email
      t.string :gender
      t.text :request
      t.string :check
      




      t.timestamps
    end
  end
end
