class HomeController < ApplicationController
  def show
    @first_month = Month.order(:number).first
    @jobs_count = Job.count
    @next_post_time = NextPostCalculator.new.call
  end
end
