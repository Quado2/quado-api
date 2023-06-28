class CreateMods < ActiveRecord::Migration[7.0]
  def change
    create_table :mods, id: :uuid do |t|
      t.string :title
      t.string :name

      t.timestamps
    end
  end
end
