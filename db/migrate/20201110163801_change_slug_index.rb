class ChangeSlugIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :posts, :slug
    add_index :posts, :slug
    add_index :posts, [:type, :slug], unique: true
  end
end
