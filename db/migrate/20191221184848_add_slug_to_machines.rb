class AddSlugToMachines < ActiveRecord::Migration[6.0]
  def change
    add_column :machines, :slug, :string, length: 6
    Machine.update slug: 'ajs1G4'
    change_column :machines, :slug, :string, length: 6, null: false
    add_index :machines, :slug, unique: true
  end
end
