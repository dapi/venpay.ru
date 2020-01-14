class SorceryCore < ActiveRecord::Migration[6.0]
  def change
    enable_extension "citext"

    create_table :users, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.citext :email,            null: false
      t.string :crypted_password
      t.string :salt
      t.string :name

      t.timestamps                null: false
    end

    add_index :users, :email, unique: true
  end
end
