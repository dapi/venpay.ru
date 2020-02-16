class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities, id: :uuid, default: -> { "uuid_generate_v4()" }  do |t|
      t.references :machine, null: false, foreign_key: true, type: :uuid
      t.string :message, null: false

      t.timestamps
    end
  end
end
