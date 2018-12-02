class HomeController < ApplicationController
  def show
    @first_month = Month.order(:number).first
    @jobs_count = Job.count
    @next_post_time = Date.new(2018, 12, 3).in_time_zone + 11 * 3_600
  end
end
