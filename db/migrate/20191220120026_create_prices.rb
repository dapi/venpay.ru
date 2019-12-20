class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices, id: :uuid, default: -> { "uuid_generate_v4()" }  do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.monetize :price, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_index :prices, [:account_id, :title], unique: true
  end
end
