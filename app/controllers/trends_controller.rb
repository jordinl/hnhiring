class TrendsController < ApplicationController
  helper_method :trends_technologies, :trends_locations

  def show
    @technologies = Keyword.technology.order(jobs_count: :desc)
    @technologies.limit!(5) if trends_technologies.empty?
    @technologies.where!(slug: trends_technologies) if trends_technologies.any?
    @locations = Keyword.location.where(slug: trends_locations) if trends_locations.any?
    @months    = Month.order(number: :asc)

    @counts = Keyword.technology.left_joins(jobs: [:month, :job_keywords])
                .group('months.id', :id)
                .select('keywords.*, months.id as month_id, count(distinct(jobs)) as count')
                .where(id: @technologies)
    @counts.where!(job_keywords_jobs: { keyword_id: @locations }) if @locations
  end

  private

  def trends_technologies
    @trends_technologies ||= params[:technologies].present? ? params[:technologies].split(',') : []
  end

  def trends_locations
    @trends_locations ||= params[:locations].present? ? params[:locations].split(',') : []
  end
end
