class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.datetime :published_at
      t.string :username
      t.belongs_to :month, index: true

      t.timestamps null: false
    end
  end
end
