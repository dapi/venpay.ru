class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :public_number, null: false
      t.timestamp :last_activity_at

      t.timestamps
    end

    add_index :machines, :public_number, unique: true
  end
end
