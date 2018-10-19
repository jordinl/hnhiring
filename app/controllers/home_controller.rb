class HomeController < ApplicationController
  def show
    @last_month = Month.order(:number).last
    @first_month = Month.order(:number).first
    @jobs_count = Job.count
    @next_post_time = NextHiringPost.call

    @top_technologies = Keyword.order(jobs_count: :desc)
  end
end
