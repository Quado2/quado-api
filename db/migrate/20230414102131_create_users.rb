class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email,  null: false, index: true
      t.string :phone_number, null: false
      t.boolean :phone_verified, null: false, default: false
      t.boolean :email_verified, null: false, default: false
      t.boolean :active, null: false, default: true
      t.string :password, null: false
      t.string :verification_token
      t.datetime :verification_token_sent_at
      t.datetime :last_sign_in_at
      t.datetime :confirmed_at
      
      t.timestamps
    end
  end
end
