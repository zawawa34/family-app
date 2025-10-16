class CreateUserDatabaseAuthentications < ActiveRecord::Migration[8.0]
  def change
    create_table :user_database_authentications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false
      t.string :encrypted_password, null: false, default: ''
      t.datetime :remember_created_at

      t.timestamps
    end
    add_index :user_database_authentications, :email, unique: true
  end
end
