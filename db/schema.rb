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

ActiveRecord::Schema.define(version: 20151212174611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title",                       null: false
    t.text     "body",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "preview",                     null: false
    t.integer  "user_id"
    t.string   "slug",                        null: false
    t.string   "keywords",                    null: false
    t.string   "description",                 null: false
    t.integer  "position"
    t.boolean  "published",   default: false
  end

  add_index "articles", ["position"], name: "index_articles_on_position", using: :btree
  add_index "articles", ["published"], name: "index_articles_on_published", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "chapters", force: :cascade do |t|
    t.string   "title",                      null: false
    t.integer  "position",   default: 0,     null: false
    t.integer  "user_id",                    null: false
    t.boolean  "published",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug",                       null: false
  end

  add_index "chapters", ["position"], name: "index_chapters_on_position", using: :btree
  add_index "chapters", ["slug"], name: "index_chapters_on_slug", unique: true, using: :btree
  add_index "chapters", ["user_id"], name: "index_chapters_on_user_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title",                         null: false
    t.text     "body",                          null: false
    t.integer  "position",      default: 0,     null: false
    t.integer  "screencast_id",                 null: false
    t.integer  "user_id",                       null: false
    t.boolean  "published",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "slug",                          null: false
  end

  add_index "lessons", ["position"], name: "index_lessons_on_position", using: :btree
  add_index "lessons", ["screencast_id"], name: "index_lessons_on_screencast_id", using: :btree
  add_index "lessons", ["slug"], name: "index_lessons_on_slug", unique: true, using: :btree
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "screencasts", force: :cascade do |t|
    t.string   "title",                      null: false
    t.text     "body",                       null: false
    t.integer  "position",   default: 0,     null: false
    t.integer  "chapter_id",                 null: false
    t.integer  "user_id",                    null: false
    t.boolean  "published",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug",                       null: false
  end

  add_index "screencasts", ["chapter_id"], name: "index_screencasts_on_chapter_id", using: :btree
  add_index "screencasts", ["position"], name: "index_screencasts_on_position", using: :btree
  add_index "screencasts", ["slug"], name: "index_screencasts_on_slug", unique: true, using: :btree
  add_index "screencasts", ["user_id"], name: "index_screencasts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
