# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140219104756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "token_read"
    t.string   "token_write"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "calendar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["calendar_id"], name: "index_events_on_calendar_id", using: :btree

  create_table "gutentag_taggings", force: true do |t|
    t.integer  "tag_id",        null: false
    t.integer  "taggable_id",   null: false
    t.string   "taggable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gutentag_taggings", ["tag_id"], name: "index_gutentag_taggings_on_tag_id", using: :btree
  add_index "gutentag_taggings", ["taggable_type", "taggable_id", "tag_id"], name: "unique_taggings", unique: true, using: :btree
  add_index "gutentag_taggings", ["taggable_type", "taggable_id"], name: "index_gutentag_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "gutentag_tags", force: true do |t|
    t.string   "name",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taggings_count", default: 0, null: false
  end

  add_index "gutentag_tags", ["name"], name: "index_gutentag_tags_on_name", unique: true, using: :btree
  add_index "gutentag_tags", ["taggings_count"], name: "index_gutentag_tags_on_taggings_count", using: :btree

end
