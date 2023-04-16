class UserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :title, unique: true
      t.string :designation
    end

    add_index :roles, :title, unique: true
  end
end
