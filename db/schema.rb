# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_23_154612) do
  create_table "shopping_items", force: :cascade do |t|
    t.integer "shopping_list_id", null: false
    t.string "name", null: false
    t.string "quantity"
    t.text "memo"
    t.string "store_name"
    t.datetime "picked_at"
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picked_at"], name: "index_shopping_items_on_picked_at"
    t.index ["shopping_list_id", "position"], name: "index_shopping_items_on_shopping_list_id_and_position", unique: true
    t.index ["shopping_list_id"], name: "index_shopping_items_on_shopping_list_id"
    t.index ["store_name"], name: "index_shopping_items_on_store_name"
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.string "name", null: false
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_shopping_lists_on_owner_id"
  end

  create_table "user_database_authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_database_authentications_on_email", unique: true
    t.index ["user_id"], name: "index_user_database_authentications_on_user_id"
  end

  create_table "user_invitations", force: :cascade do |t|
    t.integer "create_user_id", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["create_user_id"], name: "index_user_invitations_on_create_user_id"
    t.index ["token"], name: "index_user_invitations_on_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "shopping_items", "shopping_lists"
  add_foreign_key "shopping_lists", "users", column: "owner_id"
  add_foreign_key "user_database_authentications", "users"
  add_foreign_key "user_invitations", "users", column: "create_user_id"
end
