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

ActiveRecord::Schema.define(version: 20191219123147) do

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.integer  "category"
    t.integer  "price"
    t.string   "required_time"
    t.string   "detail"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "menu_id"
    t.string   "date"
    t.text     "frames"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "last_name_kana"
    t.string   "first_name_kana"
    t.integer  "tel"
    t.string   "email"
    t.string   "gender"
    t.text     "request"
    t.string   "check"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "staff_id"
    t.string   "date"
    t.string   "frame"
    t.string   "frame_status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "last_name_kana"
    t.string   "first_name_kana"
    t.integer  "number"
    t.integer  "age"
    t.string   "gender"
    t.string   "experience"
    t.integer  "status"
    t.text     "self_introduction"
    t.string   "image"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
