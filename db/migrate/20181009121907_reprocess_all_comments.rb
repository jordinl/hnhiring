class ReprocessAllComments < ActiveRecord::Migration[5.2]
  def change
    Month.order(number: :desc).find_each do |month|
      ImportMonthService.new(month).call
    end
  end
end
