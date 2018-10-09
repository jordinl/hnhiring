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
    @jobs = @month.jobs.order(published_at: :desc)
    search_keywords.each do |keyword|
      @jobs.where!('description::varchar ILIKE ?', "%#{keyword}%")
    end
    @jobs.joins!(:technologies).where!(technologies: { slug: technology_keywords }) if technology_keywords.present?
    @previous_month = @month.previous_month
  end
end
