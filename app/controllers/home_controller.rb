class HomeController < ApplicationController
  def show
    @first_month = Month.order(:number).first
    @jobs_count = Job.count
    @next_post_time = next_post_date.in_time_zone + 11 * 3_600
  end

  private

  def next_post_date(target = Time.zone.now.next_month.beginning_of_month)
    return target + 2.days if target.saturday?
    return target + 1.day if target.sunday?
    target
  end
end
