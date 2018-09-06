class LoadSchema < ActiveRecord::Migration[5.2]
  def change
    enable_extension "plpgsql"

    create_table "comments", force: :cascade do |t|
      t.text     "description"
      t.datetime "published_at"
      t.string   "username"
      t.integer  "month_id"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    add_index "comments", ["month_id"], name: "index_comments_on_month_id", using: :btree

    create_table "months", force: :cascade do |t|
      t.integer  "number"
      t.string   "name"
      t.string   "url"
      t.string   "api_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
