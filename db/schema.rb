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

ActiveRecord::Schema.define(version: 20150708191222) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "image_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["image_id"], name: "index_assignments_on_image_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

  create_table "descriptions", force: :cascade do |t|
    t.string   "locale",     limit: 255,   default: "en"
    t.text     "text",       limit: 65535
    t.integer  "status_id",  limit: 4
    t.integer  "image_id",   limit: 4
    t.integer  "metum_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "descriptions", ["image_id"], name: "index_descriptions_on_image_id", using: :btree
  add_index "descriptions", ["metum_id"], name: "index_descriptions_on_metum_id", using: :btree
  add_index "descriptions", ["status_id"], name: "index_descriptions_on_status_id", using: :btree
  add_index "descriptions", ["user_id"], name: "index_descriptions_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: :cascade do |t|
    t.string   "url",          limit: 255
    t.integer  "website_id",   limit: 4
    t.integer  "group_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "canonical_id", limit: 255
  end

  add_index "images", ["group_id"], name: "index_images_on_group_id", using: :btree
  add_index "images", ["website_id"], name: "index_images_on_website_id", using: :btree

  create_table "meta", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "instructions", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                  limit: 1,   default: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "websites", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "assignments", "images"
  add_foreign_key "assignments", "users"
  add_foreign_key "descriptions", "images"
  add_foreign_key "descriptions", "meta"
  add_foreign_key "descriptions", "statuses"
  add_foreign_key "descriptions", "users"
  add_foreign_key "images", "groups"
  add_foreign_key "images", "websites"
end
