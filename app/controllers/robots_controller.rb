class RobotsController < ApplicationController
  layout false

  def show
    render 'robots/disallow_all' if Rails.env.production?
  end
end
