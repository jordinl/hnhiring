class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :search_technologies, :search_locations, :all_technologies, :all_locations, :latest_hiring_post,
                :latest_freelancer_post

  before_action :set_raven_context

  private

  def search_keywords
    return [] if params[:q].blank?
    params[:q].split(',').map(&:squish!)
  end

  def search_technologies
    []
  end

  def search_locations
    []
  end

  def all_technologies
    @all_technologies ||= Keyword.technology.all
  end

  def all_locations
    @all_locations ||= Keyword.location.all
  end

  def latest_hiring_post
    @latest_hiring_post ||= HiringPost.order(:number).last
  end

  def latest_freelancer_post
    @latest_freelancer_post ||= FreelancerPost.order(:number).last
  end

  def set_raven_context
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
