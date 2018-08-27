class HomeController < ApplicationController
  def show
    @month = Month.last
    @comments = @month.comments.order(published_at: :desc)
  end
end
