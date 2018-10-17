class IndexJobsDescription < ActiveRecord::Migration[5.2]
  def up
    execute("CREATE EXTENSION pg_trgm;")
    execute("CREATE INDEX index_jobs_on_description ON jobs using gin (description gin_trgm_ops);")
  end

  def down
    execute("DROP INDEX index_jobs_on_description;")
    execute("DROP EXTENSION pg_trgm;")
  end
end
