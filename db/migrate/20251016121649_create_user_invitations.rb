class CreateUserInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :user_invitations do |t|
      t.references :create_user, null: false, foreign_key: { to_table: :users }
      t.string :token, null: false
      t.datetime :expires_at, null: false
      t.integer :status, null: false, default: 0 # 0: unused, 1: used

      t.timestamps
    end
    add_index :user_invitations, :token, unique: true
  end
end
