class AddWorkTimeToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :prices, :work_time, :integer
    Price.update_all work_time: 1
    change_column :prices, :work_time, :integer, null: false
  end
end
