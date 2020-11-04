class RenameJobKeywordsToCommentKeywords < ActiveRecord::Migration[5.2]
  def change
    rename_table :job_keywords, :comment_keywords
  end
end
