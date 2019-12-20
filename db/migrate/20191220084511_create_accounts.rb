class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :title, null: false
      t.timestamps
    end

    add_index :accounts, :title, unique: true
  end
end
