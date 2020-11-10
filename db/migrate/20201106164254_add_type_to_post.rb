class AddTypeToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :type, :string, default: 'HiringPost'
    add_index :posts, :type
  end
end
