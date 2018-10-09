class RobotsController < ApplicationController
  layout false

  def show
    render 'robots/disallow_all' unless Rails.env.production?
  end
end
