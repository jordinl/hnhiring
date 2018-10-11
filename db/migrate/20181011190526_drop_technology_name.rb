class DropTechnologyName < ActiveRecord::Migration[5.2]
  def change
    remove_column :technologies, :name, :string
  end
end
