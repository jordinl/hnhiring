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

  def technology
    @technology = Technology.find_by!(slug: params[:technology])
    @month = Month.find_by(slug: params[:month]) || Month.order(:number).last
    find_jobs
  end

  private

  def find_jobs
    @jobs = @month.jobs.order(published_at: :desc)
    search_keywords.each do |keyword|
      @jobs.where!('description::varchar ILIKE ?', "%#{keyword}%")
    end
    @jobs.joins!(:technologies).where!(technologies: { slug: technology_keywords }) if technology_keywords.present?
    @jobs.distinct!
    @previous_month = @month.previous_month
  end
end
