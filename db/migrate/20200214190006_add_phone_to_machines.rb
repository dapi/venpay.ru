class AddPhoneToMachines < ActiveRecord::Migration[6.0]
  def change
    add_column :machines, :phone, :string
  end
end
