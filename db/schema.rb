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

ActiveRecord::Schema.define(version: 20150826054524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title",          null: false
    t.string   "subtitle"
    t.date     "begin_date",     null: false
    t.date     "end_date",       null: false
    t.text     "body"
    t.integer  "tag_id",         null: false
    t.integer  "newspaper_id",   null: false
    t.integer  "libertarian_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "articles", ["libertarian_id"], name: "index_articles_on_libertarian_id", using: :btree
  add_index "articles", ["newspaper_id"], name: "index_articles_on_newspaper_id", using: :btree
  add_index "articles", ["tag_id"], name: "index_articles_on_tag_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",          null: false
    t.date     "begin_date",     null: false
    t.date     "end_date",       null: false
    t.text     "body"
    t.integer  "tag_id",         null: false
    t.integer  "libertarian_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "events", ["libertarian_id"], name: "index_events_on_libertarian_id", using: :btree
  add_index "events", ["tag_id"], name: "index_events_on_tag_id", using: :btree

  create_table "libertarians", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "newspapers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "title",          null: false
    t.string   "subtitle"
    t.date     "begin_date",     null: false
    t.date     "end_date",       null: false
    t.text     "body"
    t.integer  "tag_id",         null: false
    t.integer  "newspaper_id",   null: false
    t.integer  "libertarian_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "reports", ["libertarian_id"], name: "index_reports_on_libertarian_id", using: :btree
  add_index "reports", ["newspaper_id"], name: "index_reports_on_newspaper_id", using: :btree
  add_index "reports", ["tag_id"], name: "index_reports_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "writing_entries", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "vendor"
    t.string   "author"
    t.integer  "writing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "writing_entries", ["writing_id"], name: "index_writing_entries_on_writing_id", using: :btree

  create_table "writings", force: :cascade do |t|
    t.date     "begin_date",     null: false
    t.date     "end_date",       null: false
    t.integer  "tag_id",         null: false
    t.integer  "libertarian_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "writings", ["libertarian_id"], name: "index_writings_on_libertarian_id", using: :btree
  add_index "writings", ["tag_id"], name: "index_writings_on_tag_id", using: :btree

end
