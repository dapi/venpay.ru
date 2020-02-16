class AddAdapterClassToMachines < ActiveRecord::Migration[6.0]
  def change
    add_column :machines, :adapter_class, :string
    Machine.update_all adapter_class: RovosAdapter.name
    change_column_null :machines, :adapter_class, false
  end
end
