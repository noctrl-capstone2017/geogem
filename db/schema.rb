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

ActiveRecord::Schema.define(version: 20170602221016) do

  create_table "roster_squares", force: :cascade do |t|
    t.integer  "square_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roster_students", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id", "teacher_id"], name: "index_roster_students_on_student_id_and_teacher_id", unique: true
  end

  create_table "schools", force: :cascade do |t|
    t.string   "full_name"
    t.string   "screen_name"
    t.string   "icon"
    t.string   "color"
    t.string   "email"
    t.string   "website"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "session_events", force: :cascade do |t|
    t.integer  "behavior_square_id"
    t.datetime "square_press_time"
    t.datetime "duration_end_time"
    t.integer  "session_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "session_notes", force: :cascade do |t|
    t.text     "note"
    t.integer  "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "session_teacher"
    t.integer  "session_student"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "squares", force: :cascade do |t|
    t.string   "full_name"
    t.string   "screen_name"
    t.string   "color"
    t.integer  "tracking_type"
    t.text     "description"
    t.integer  "school_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "full_name"
    t.string   "screen_name"
    t.string   "icon"
    t.string   "color"
    t.string   "contact_info"
    t.text     "description"
    t.integer  "session_interval", default: 15
    t.integer  "school_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "user_name"
    t.string   "password_digest"
    t.datetime "last_login"
    t.string   "full_name"
    t.string   "screen_name"
    t.string   "icon"
    t.string   "color"
    t.string   "email"
    t.text     "description"
    t.string   "powers"
    t.integer  "school_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "suspended",       default: false, null: false
  end

end
