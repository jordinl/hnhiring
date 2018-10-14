class NextHiringPost
  def self.call
    now = Time.zone.now
    date = Time.zone.today
    publish_time = 11 * 3_600

    date = date.next_day if (now.hour * 3_600 + now.min * 60 + now.sec) >= publish_time
    date = date.next_month.at_beginning_of_month if date.day > 7
    date = date + 8 - date.wday unless date.monday?
    date.in_time_zone + publish_time
  end
end
