class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :staff_id
      t.string :date
      t.string :frame
      t.string :frame_status
      t.timestamps
    end
  end
end
