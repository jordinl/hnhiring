class HomeController < ApplicationController
  before_action :redirect_to_month_if_searching

  def show
    @months = Month.select('months.*, max(published_at) as published_at')
                .joins(:comments)
                .group(:id)
                .order(number: :desc)
  end

  private

  def redirect_to_month_if_searching
    redirect_to month_path(Month.order(:number).last, request.query_parameters) if searching?
  end
end
