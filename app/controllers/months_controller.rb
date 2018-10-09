class MonthsController < ApplicationController
  def show
    @month = Month.find_by!(slug: params[:id])
    @last_month = @month.id == Month.order(:number).pluck(:id).last
    show_month
  end

  def search
    @month = Month.order(:number).last
    show_month
    render :show
  end

  private

  def show_month
    @comments = @month.comments.order(published_at: :desc)
    search_keywords.each do |keyword|
      @comments.where!('description::varchar ILIKE ?', "%#{keyword}%")
    end
    @previous_month = @month.previous_month
  end
end
