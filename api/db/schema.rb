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

ActiveRecord::Schema.define(version: 2023_05_06_163840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "resource_faqs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.text "question", null: false
    t.text "answer", null: false
    t.bigint "resource_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resource_id"], name: "index_resource_faqs_on_resource_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.text "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_resources_on_created_at"
    t.index ["slug"], name: "index_resources_on_slug"
  end

  add_foreign_key "resource_faqs", "resources"
end
