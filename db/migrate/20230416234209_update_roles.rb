class UpdateRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :created_at, :datetime, null: false
    add_column :roles, :updated_at, :datetime, null: false    

  end
end
