class HomeController < ApplicationController
  def show
    @first_post = Post.order(:number).first
    @jobs_count = Comment.count
    @next_post_time = NextPostCalculator.new.call
  end
end
