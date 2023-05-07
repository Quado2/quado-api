class RenameUserRole < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_role, :user_roles
  end
end
