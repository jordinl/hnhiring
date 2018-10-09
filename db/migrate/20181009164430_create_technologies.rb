class CreateTechnologies < ActiveRecord::Migration[5.2]
  def change
    create_table :technologies do |t|
      t.string :name
      t.string :slug, index: true
      t.integer :jobs_count, default: 0

      t.timestamps
    end
  end
end
