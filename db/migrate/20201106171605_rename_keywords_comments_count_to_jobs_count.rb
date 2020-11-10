class RenameKeywordsCommentsCountToJobsCount < ActiveRecord::Migration[5.2]
  def change
    rename_column :keywords, :comments_count, :jobs_count
  end
end
