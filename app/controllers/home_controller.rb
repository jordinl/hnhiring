class HomeController < ApplicationController
  def show
    @month = Month.order(:number).last
    @comments = @month.comments.order(published_at: :desc)
    @previous_month = @month.previous_month
  end
end
