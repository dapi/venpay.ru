class ChangeSlugAndNumberLimits < ActiveRecord::Migration[6.0]
  def change
    change_column :machines, :public_number, :string, limit: 6
    change_column :machines, :slug, :string, limit: 6
  end
end
