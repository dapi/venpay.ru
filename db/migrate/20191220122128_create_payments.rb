class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.references :machine, null: false, foreign_key: true, type: :uuid
      t.references :price, null: false, foreign_key: true, type: :uuid
      t.monetize :total_price
      t.string :title, null: false
      t.string :state, null: false, default: PaymentState::STATE_AWAIT

      t.timestamps
    end

    add_column :accounts, :cloud_payments_public_id, :string
    add_column :accounts, :cloud_payments_api_key, :string
  end
end
