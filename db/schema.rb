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

ActiveRecord::Schema.define(version: 2019_02_08_102244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "achievements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.float "credit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "category"
    t.string "course_id"
    t.boolean "self_certifiable", default: false
    t.index ["category"], name: "index_activities_on_category"
    t.index ["course_id"], name: "index_activities_on_course_id", unique: true
    t.index ["self_certifiable"], name: "index_activities_on_self_certifiable"
    t.index ["slug"], name: "index_activities_on_slug", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "last_sign_in_at"
    t.string "stem_user_id"
    t.string "stem_achiever_contact_no"
    t.datetime "stem_credentials_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_stem_credentials_access_token"
    t.string "encrypted_stem_credentials_access_token_iv"
    t.string "encrypted_stem_credentials_refresh_token"
    t.string "encrypted_stem_credentials_refresh_token_iv"
    t.index ["stem_user_id"], name: "index_users_on_stem_user_id", unique: true
  end

end
