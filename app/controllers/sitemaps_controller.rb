class SitemapsController < ApplicationController
  layout false

  def show
    @months = Month.joins(:jobs)
                .select(:id, :slug, 'max(jobs.published_at) as published_at')
                .group(:id)
  end
end
