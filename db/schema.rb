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

ActiveRecord::Schema[8.1].define(version: 2026_04_24_094428) do
  create_table "apartments", force: :cascade do |t|
    t.float "area"
    t.datetime "created_at", null: false
    t.boolean "fragmented", default: false, null: false
    t.string "name"
    t.string "number", null: false
    t.integer "parent_apartment_id"
    t.string "prefix"
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_apartments_on_number"
    t.index ["parent_apartment_id"], name: "index_apartments_on_parent_apartment_id"
  end

  add_foreign_key "apartments", "apartments", column: "parent_apartment_id"
end
