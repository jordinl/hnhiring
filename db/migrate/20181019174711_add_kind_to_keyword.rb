class AddKindToKeyword < ActiveRecord::Migration[5.2]
  def change
    add_column :keywords, :kind, :string
    Keyword.update_all(kind: 'technology')
    add_index :keywords, :kind
  end
end
