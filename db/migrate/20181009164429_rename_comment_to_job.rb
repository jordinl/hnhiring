class RenameCommentToJob < ActiveRecord::Migration[5.2]
  def change
    rename_table :comments, :jobs
    rename_column :months, :comments_count, :jobs_count
  end
end
