class IndexNumberOnMonth < ActiveRecord::Migration[5.2]
  def change
    add_index :months, :number
  end
end
