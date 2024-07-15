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

ActiveRecord::Schema[7.1].define(version: 2024_07_15_072701) do
  create_table "tag_working_times", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "working_time_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id", "working_time_id"], name: "index_tag_working_times_on_tag_id_and_working_time_id", unique: true
    t.index ["tag_id"], name: "index_tag_working_times_on_tag_id"
    t.index ["working_time_id"], name: "index_tag_working_times_on_working_time_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "working_times", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tag_working_times", "tags"
  add_foreign_key "tag_working_times", "working_times"
end
