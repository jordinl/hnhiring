class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :technology_keywords

  private

  def search_keywords
    return [] if params[:q].blank?
    params[:q].split(',').map(&:squish!)
  end

  def technology_keywords
    return [] if params[:technologies].blank? && params[:technology].blank?
    @technology_keywords ||= [params[:technologies], [params[:technology]]]
                               .select(&:present?)
                               .join(',')
                               .split(',')
                               .map(&:squish!)
  end

  def location_keywords
    return [] if params[:locations].blank? && params[:location].blank?
    @location_keywords ||= [params[:locations], [params[:location]]]
                             .select(&:present?)
                             .join(',')
                             .split(',')
                             .map(&:squish!)
  end
end
