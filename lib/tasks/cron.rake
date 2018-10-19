task :cron => :environment do
  ImportMonthService.new.call
  Keyword.populate!
end
