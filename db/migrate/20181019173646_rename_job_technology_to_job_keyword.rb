class RenameJobTechnologyToJobKeyword < ActiveRecord::Migration[5.2]
  def change
    rename_table :job_technologies, :job_keywords
  end
end
