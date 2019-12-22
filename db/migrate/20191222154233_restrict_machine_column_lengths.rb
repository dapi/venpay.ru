class RestrictMachineColumnLengths < ActiveRecord::Migration[6.0]
  def up
    change_column :machines, :public_number, :string, limit: 5
    change_column :machines, :slug, :string, limit: 6
  end
end
