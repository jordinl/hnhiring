class CreateJobTechnologies < ActiveRecord::Migration[5.2]
  def change
    create_table :job_technologies do |t|
      t.belongs_to :job, foreign_key: true
      t.belongs_to :technology, foreign_key: true

      t.timestamps
    end
  end
end
