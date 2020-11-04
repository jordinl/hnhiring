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

ActiveRecord::Schema.define(version: 2020_11_04_160737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "comment_keywords", force: :cascade do |t|
    t.bigint "comment_id"
    t.bigint "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comment_keywords_on_comment_id"
    t.index ["keyword_id"], name: "index_comment_keywords_on_keyword_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "description"
    t.datetime "published_at"
    t.string "username"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_id"
    t.index ["api_id"], name: "index_comments_on_api_id"
    t.index ["description"], name: "index_comments_on_description", opclass: :gin_trgm_ops, using: :gin
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "slug"
    t.integer "comments_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.index ["kind"], name: "index_keywords_on_kind"
    t.index ["slug"], name: "index_keywords_on_slug"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "number"
    t.string "api_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "comments_count", default: 0
    t.string "slug"
    t.index ["number"], name: "index_posts_on_number"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  add_foreign_key "comment_keywords", "comments"
  add_foreign_key "comment_keywords", "keywords"
end
