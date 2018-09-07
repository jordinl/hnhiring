task :cron => :environment do
  ImportMonthService.new.call
end
