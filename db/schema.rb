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

ActiveRecord::Schema.define(version: 20140807161425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airlines", force: true do |t|
    t.string   "name"
    t.string   "fs_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "airlines", ["fs_code"], name: "index_airlines_on_fs_code", unique: true, using: :btree

  create_table "airports", force: true do |t|
    t.string   "name"
    t.string   "fs_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flights", force: true do |t|
    t.integer  "airline_id"
    t.integer  "departure_airport_id"
    t.integer  "arrival_airport_id"
    t.integer  "fs_code"
    t.string   "flight_number"
    t.datetime "departure_scheduled"
    t.datetime "departure_actual"
    t.datetime "arrival_scheduled"
    t.datetime "arrival_actual"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "flight_id"
    t.boolean  "satisfied"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
