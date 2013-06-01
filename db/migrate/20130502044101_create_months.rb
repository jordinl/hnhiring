class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.integer :number
      t.string :name
      t.string :url
      t.string :api_id

      t.timestamps
    end
  end
end
