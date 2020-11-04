class RenameMonthsToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_table :months, :posts
    rename_column :jobs, :month_id, :post_id
  end
end
