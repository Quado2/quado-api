class CreateUserRole < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :role, null: false, foreign_Key: true, type: :uuid
      t.timestamps
    end
  end
end
