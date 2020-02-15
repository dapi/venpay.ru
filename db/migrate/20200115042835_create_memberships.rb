class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :memberships, [:account_id, :user_id], unique: true
  end
end
