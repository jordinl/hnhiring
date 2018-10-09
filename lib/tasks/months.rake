namespace :months do
  task fetch_all: :environment do
    Month.order(number: :desc).find_each do |month|
      ImportMonthService.new(month).call
    end
  end
end
