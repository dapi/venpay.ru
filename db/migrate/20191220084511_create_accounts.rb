class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    enable_extension "uuid-ossp"

    create_table :accounts, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :title, null: false
      t.timestamps
    end

    add_index :accounts, :title, unique: true
  end
end
