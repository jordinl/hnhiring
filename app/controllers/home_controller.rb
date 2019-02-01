class HomeController < ApplicationController
  def show
    @first_month = Month.order(:number).first
    @jobs_count = Job.count
    @next_post_time = Time.zone.now.next_month.beginning_of_month.in_time_zone + 11 * 3_600
  end
end
