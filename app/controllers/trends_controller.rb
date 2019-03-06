class TrendsController < ApplicationController
  def show
    @technologies = Keyword.technology.order(jobs_count: :desc)
    @technologies.limit!(5) if params[:technologies].blank?
    @technologies.where!(slug: params[:technologies].split(',')) if params[:technologies].present?
    @locations = Keyword.location.where(slug: params[:locations].split(',')) if params[:locations].present?
    @months    = Month.order(number: :asc)

    @counts = Keyword.technology.left_joins(jobs: [:month, :job_keywords])
                .group('months.id', :id)
                .select('keywords.*, months.id as month_id, count(distinct(jobs)) as count')
                .where(id: @technologies)
    @counts.where!(job_keywords_jobs: { keyword_id: @locations }) if @locations
  end
end
