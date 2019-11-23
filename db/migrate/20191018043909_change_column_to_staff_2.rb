class ChangeColumnToStaff2 < ActiveRecord::Migration[5.0]
  def up
    change_column :staffs, :status, :integer
  end
  
  def down
    change_column :staffs, :status, :string
  end
end
