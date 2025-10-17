class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.integer :role, null: false, default: 1 # 0: admin, 1: general

      t.timestamps
    end
  end
end
