class CreatePrivileges < ActiveRecord::Migration[7.0]
  def change
    create_table :privileges, id: :uuid do |t|
      t.belongs_to :role, type: :uuid, null: false, foreign_key: true
      t.belongs_to :mod, type: :uuid, null: false, foreign_key: true
      t.boolean :create
      t.boolean :edit
      t.boolean :update
      t.boolean :delete

      t.timestamps
    end
  end
end
