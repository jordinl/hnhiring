class SitemapsController < ApplicationController
  layout false

  def show
    @months = Month.joins(:jobs)
                .select(:id, :slug, 'max(jobs.published_at) as max_published_at')
                .group(:id)

    @locations = Keyword.location.joins(:job_keywords)
                   .select(:id, :slug, 'max(job_keywords.created_at) as updated_at')
                   .group(:id)

    @technologies = Keyword.technology.joins(:job_keywords)
                      .select(:id, :slug, 'max(job_keywords.created_at) as updated_at')
                      .group(:id)
  end
end
