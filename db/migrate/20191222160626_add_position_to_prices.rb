class AddPositionToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :prices, :position, :integer, null: false, default: 0
    add_index :prices, [:account_id, :position]
  end
end
