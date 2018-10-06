class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def searching?
    params[:q].present?
  end

  def search_keywords
    return [] unless searching?
    params[:q].split(',').map(&:squish!)
  end
end
