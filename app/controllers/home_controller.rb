class HomeController < ApplicationController
  def show
    @months = Month.select('months.*, max(published_at) as published_at')
                .joins(:jobs)
                .group(:id)
                .order(number: :desc)
  end
end
