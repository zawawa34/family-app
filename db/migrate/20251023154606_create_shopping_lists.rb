class CreateShoppingLists < ActiveRecord::Migration[8.0]
  def change
    create_table :shopping_lists do |t|
      t.string :name, null: false
      t.references :owner, foreign_key: { to_table: :users }, null: true

      t.timestamps
    end
  end
end
