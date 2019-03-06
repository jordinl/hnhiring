class JobsController < ApplicationController
  def index
    @month = Month.find_by!(slug: params[:month])
    find_jobs
  end

  def search
    @month = Month.order(:number).last
    find_jobs
    render :index
  end

  def keyword
    keyword_param = params[:technology] || params[:location]
    keyword_kind = params.has_key?(:technology) ? :technology : :location
    @technology = Keyword.find_by!(slug: keyword_param, kind: keyword_kind)
    @month = Month.find_by(slug: params[:month]) || Month.order(:number).last
    find_jobs
  end

  private

  def find_jobs
    @jobs = @month.jobs.order(published_at: :desc)
    search_keywords.each do |keyword|
      @jobs.where!('description::varchar ILIKE ?', "%#{keyword}%")
    end
    @jobs.where!(id: Job.joins(:keywords).merge(Keyword.technology.where(slug: search_technologies))) if search_technologies.present?
    @jobs.where!(id: Job.joins(:keywords).merge(Keyword.location.where(slug: search_locations))) if search_locations.present?
    @jobs.distinct!
    @previous_month = @month.previous_month
  end

  def search_technologies
    return [] if params[:technologies].blank? && params[:technology].blank?
    @search_technologies ||= [params[:technologies], [params[:technology]]]
                               .select(&:present?)
                               .join(',')
                               .split(',')
                               .map(&:squish!)
  end

  def search_locations
    return [] if params[:locations].blank? && params[:location].blank?
    @search_locations ||= [params[:locations], [params[:location]]]
                             .select(&:present?)
                             .join(',')
                             .split(',')
                             .map(&:squish!)
  end
end
