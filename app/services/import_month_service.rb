class ImportMonthService
  def initialize(number: nil, api_id: nil)
    @number = number || current_month
    @api_id = api_id || SearchParser.new.call
  end

  def call
    month = Month.find_or_create_by!(number: @number, api_id: @api_id)
    month.load_comments if month.present?
  end

  private

  def current_month
    year, month = Time.now.year, Time.now.month
    year * 100 + month
  end
end
