class PrivilegeTypeChange < ActiveRecord::Migration[7.0]
  def change
    remove_column :privileges, :can_read
    add_column :privileges, :can_read, :boolean
  end
end
