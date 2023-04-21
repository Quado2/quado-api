class RenameRolesDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :roles, :designation, :description
  end
end
