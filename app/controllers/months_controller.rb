class MonthsController < ApplicationController
  def show
    @month = Month.find_by!(slug: params[:id])
    @comments = @month.comments.order(published_at: :desc)
    @previous_month = @month.previous_month
  end
end
