task :cron => :environment do
  HackerNews.get_last_hiring_post!
end
