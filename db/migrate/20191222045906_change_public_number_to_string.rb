class ChangePublicNumberToString < ActiveRecord::Migration[6.0]
  def change
    change_column :machines, :public_number, :string, length: 6
  end
end
