class MonthsController < ApplicationController

  def show
    @month = Month.find_by_number(params[:id])
    render "home/show"
  end

end
