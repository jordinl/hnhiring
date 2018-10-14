task :cron => :environment do
  ImportMonthService.new.call
  Technology.populate!
end
