class AddApiIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :api_id, :string
    add_index :comments, :api_id
  end
end
