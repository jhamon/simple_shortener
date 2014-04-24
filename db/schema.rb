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

ActiveRecord::Schema.define(version: 20140424025032) do

  create_table "page_views", force: true do |t|
    t.integer  "shortlink_id",             null: false
    t.string   "ip_address",               null: false
    t.text     "user_agent",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "referrer"
  end

  add_index "page_views", ["shortlink_id"], name: "index_page_views_on_shortlink_id"

  create_table "shortlinks", force: true do |t|
    t.integer  "target_url_id", null: false
    t.integer  "owner_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "target_urls", force: true do |t|
    t.string   "url",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",      null: false
    t.string   "password_hash", null: false
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username"

end
