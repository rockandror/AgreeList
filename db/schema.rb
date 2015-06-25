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

ActiveRecord::Schema.define(version: 20150625181243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreements", force: true do |t|
    t.string   "url"
    t.integer  "individual_id"
    t.integer  "statement_id"
    t.integer  "extent"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "hashed_id"
  end

  add_index "agreements", ["hashed_id"], name: "index_agreements_on_hashed_id", using: :btree
  add_index "agreements", ["statement_id", "created_at"], name: "index_agreements_on_statement_id_and_created_at", using: :btree

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "individual_id"
    t.integer  "statement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
  end

  create_table "delegations", force: true do |t|
    t.integer  "representative_id"
    t.integer  "represented_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individuals", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "twitter"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "uid"
    t.integer  "followers_count"
    t.string   "email"
    t.integer  "entrepreneurship_statements_count", default: 0
    t.string   "description"
    t.text     "bio"
    t.string   "hashed_id"
    t.boolean  "update_picture",                    default: true
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statements", force: true do |t|
    t.string   "content"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "hashed_id"
    t.integer  "agree_counter",    default: 0
    t.integer  "disagree_counter", default: 0
  end

  add_index "statements", ["hashed_id"], name: "index_statements_on_hashed_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "via", force: true do |t|
    t.integer  "agreement_id"
    t.integer  "individual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
