class HomeController < ApplicationController
  def show
    @first_post = HiringPost.order(:number).first
    @jobs_count = HiringPost.sum(:comments_count)
    @next_post_time = NextPostCalculator.new.call
  end
end
