class FixOldMonthsPublishedAt < ActiveRecord::Migration[5.2]
  def change
    Month.where('number < 201807').each do |month|
      start_date = Date.new(month.year, month.month, 1)
      offset = 16 + rand(10)

      month.comments.find_each do |comment|
        comment.update_columns(published_at: start_date + rand(offset))
      end
    end
  end
end
