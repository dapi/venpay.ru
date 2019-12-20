class AddEncryptedToCloudPaymentsKey < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :cloud_payments_api_key

    add_column :accounts, :encrypted_cloud_payments_api_key, :string
    add_column :accounts, :encrypted_cloud_payments_api_key_iv, :string
  end
end
