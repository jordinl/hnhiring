class DropUnnecessaryColumnsFromMonth < ActiveRecord::Migration[5.2]
  def change
    remove_column :months, :url
    remove_column :months, :name
  end
end
