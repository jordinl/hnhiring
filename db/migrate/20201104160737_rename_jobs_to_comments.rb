class RenameJobsToComments < ActiveRecord::Migration[5.2]
  def change
    rename_table :jobs, :comments
    rename_column :comment_keywords, :job_id, :comment_id
    rename_column :posts, :jobs_count, :comments_count
    rename_column :keywords, :jobs_count, :comments_count
  end
end
