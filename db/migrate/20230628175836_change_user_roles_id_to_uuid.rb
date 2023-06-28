class ChangeUserRolesIdToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :user_roles, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :user_roles do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE user_roles ADD PRIMARY KEY (id);"
  end
end
