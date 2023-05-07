class DropUserRole < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_roles
  end
end
