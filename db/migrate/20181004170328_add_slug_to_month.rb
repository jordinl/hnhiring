class AddSlugToMonth < ActiveRecord::Migration[5.2]
  def change
    add_column :months, :slug, :string
    add_index :months, :slug, unique: true
    Month.find_each do |month|
      month.update_columns(slug: "#{Date::MONTHNAMES[month.month].downcase}-#{month.year}")
    end
  end
end
