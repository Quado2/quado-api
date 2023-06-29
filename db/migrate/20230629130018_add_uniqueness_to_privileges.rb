class AddUniquenessToPrivileges < ActiveRecord::Migration[7.0]
  def change
    add_index :privileges, [:mod_id, :role_id], unique: true
  end
end
