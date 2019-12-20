class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.integer :internal_id, null: false
      t.integer :public_number, null: false
      t.timestamp :last_activity_at
      t.string :location, null: false
      t.string :description

      t.timestamps
    end

    add_index :machines, :internal_id, unique: true
    add_index :machines, :public_number, unique: true
  end
end
