# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_01_10_063322) do

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
    t.integer "jobs_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.index ["kind", "jobs_count"], name: "index_keywords_on_kind_and_jobs_count"
    t.index ["slug"], name: "index_keywords_on_slug"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "number"
    t.string "api_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "comments_count", default: 0
    t.string "slug"
    t.string "type", default: "HiringPost"
    t.index ["number"], name: "index_posts_on_number"
    t.index ["slug"], name: "index_posts_on_slug"
    t.index ["type", "slug"], name: "index_posts_on_type_and_slug", unique: true
    t.index ["type"], name: "index_posts_on_type"
  end

  add_foreign_key "comment_keywords", "comments"
  add_foreign_key "comment_keywords", "keywords"
end
