class RenameTechnologyToKeyword < ActiveRecord::Migration[5.2]
  def change
    rename_table :technologies, :keywords
    rename_column :comment_keywords, :technology_id, :keyword_id
  end
end
