class CounterCacheCommentsInMonths < ActiveRecord::Migration[5.2]
  def change
    add_column :months, :comments_count, :integer, default: 0
    Month.find_each do |month|
      Month.reset_counters(month.id, :comments)
    end
  end
end
