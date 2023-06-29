class UpdatePrivilegesTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :privileges, :update
    add_column :privileges, :read, :string
  end
end
