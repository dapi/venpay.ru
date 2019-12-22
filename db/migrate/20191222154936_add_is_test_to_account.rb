class AddIsTestToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :is_test, :boolean, null: false, default: true
  end
end
