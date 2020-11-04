class TrendsController < ApplicationController
  helper_method :trends_technologies, :trends_locations

  def show
    @technologies = Keyword.technology.order(jobs_count: :desc)
    @technologies.limit!(10) if trends_technologies.empty?
    @technologies.where!(slug: trends_technologies) if trends_technologies.any?
    @locations = Keyword.location.where(slug: trends_locations) if trends_locations.any?
    @posts    = Post.order(number: :asc)

    @counts = Keyword.technology.left_joins(jobs: [:post, :job_keywords])
                .group('posts.id', :id)
                .select('keywords.*, posts.id as post_id, count(distinct(jobs)) as count')
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
