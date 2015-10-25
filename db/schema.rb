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

ActiveRecord::Schema.define(version: 20151022211534) do

  create_table "memberships", force: :cascade do |t|
    t.integer  "paak_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "period_id",  limit: 4,   null: false
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "memberships", ["period_id", "paak_id"], name: "index_memberships_on_period_id_and_paak_id", unique: true, using: :btree
  add_index "memberships", ["period_id", "user_id"], name: "index_memberships_on_period_id_and_user_id", unique: true, using: :btree

  create_table "periods", force: :cascade do |t|
    t.integer  "number",      limit: 4
    t.integer  "code",        limit: 4
    t.string   "explanation", limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "period_id",  limit: 4
    t.string   "url",        limit: 255
    t.string   "image_url",  limit: 255
    t.text     "summary",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "records", force: :cascade do |t|
    t.datetime "timestamp"
    t.integer  "membership_id", limit: 4
    t.integer  "code",          limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "records", ["membership_id"], name: "index_records_on_membership_id", using: :btree

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "project_id", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_projects", ["project_id", "user_id"], name: "index_user_projects_on_project_id_and_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255,                null: false
    t.string   "url",                    limit: 255
    t.string   "image_url",              limit: 255
    t.text     "bio",                    limit: 65535
    t.boolean  "is_admin"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
