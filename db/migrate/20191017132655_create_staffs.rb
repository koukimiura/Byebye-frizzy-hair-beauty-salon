class CreateStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :staffs do |t|

      t.string :last_name
      t.string :first_name
      t.string :last_name_kana
      t.string :first_name_kana
      t.integer :number
      t.integer :age
      t.string :gender
      t.string :experience
      #t.string :status
      t.text :self_introduction
      t.string :image
      



      t.timestamps
    end
  end
end
