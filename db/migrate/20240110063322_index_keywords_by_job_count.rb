class IndexKeywordsByJobCount < ActiveRecord::Migration[6.1]
  def change
    remove_index :keywords, :kind
    add_index :keywords, [:kind, :jobs_count]
  end
end
