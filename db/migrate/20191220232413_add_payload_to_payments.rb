class AddPayloadToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :payload, :text
    add_column :payments, :hmac_token, :string
  end
end
