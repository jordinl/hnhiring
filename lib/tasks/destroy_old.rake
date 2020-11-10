task destroy_old: :environment do
  Post.where('number < ?', 2.months.ago.strftime('%Y%m')).destroy_all
end
