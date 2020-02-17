class ChangeInternalIdTypeToString < ActiveRecord::Migration[6.0]
  def change
    change_column :machines, :internal_id, :string, null: false
  end
end
