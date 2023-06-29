class RenamePrivilegesTableColumn < ActiveRecord::Migration[7.0]
  def change
    change_table(:privileges) do |t|
      t.rename("delete", "can_delete")
      t.rename("read", "can_read")
      t.rename("edit", "can_edit")
      t.rename("create", "can_create")
    end
  end
end
