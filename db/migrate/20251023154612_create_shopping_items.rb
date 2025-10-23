class CreateShoppingItems < ActiveRecord::Migration[8.0]
  def change
    create_table :shopping_items do |t|
      t.references :shopping_list, null: false, foreign_key: true
      t.string :name, null: false
      t.string :quantity
      t.text :memo
      t.string :store_name
      t.datetime :picked_at
      t.integer :position, null: false

      t.timestamps
    end

    add_index :shopping_items, [ :shopping_list_id, :position ], unique: true
    add_index :shopping_items, :store_name
    add_index :shopping_items, :picked_at
  end
end
