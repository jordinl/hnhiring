class ImportMonthService
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  def initialize(number: nil, api_id: nil)
    @number = number || current_month
    @api_id = api_id || SearchParser.new.call
  end

  def call
    month = Month.find_or_create_by!(number: @number, api_id: @api_id)
    return unless month

    html_comments = CommentsParser.new(month.url).call

    month.comments.destroy_all

    html_comments.each do |comment|
      published_at = Chronic.parse(comment['date'])
      description = format(comment['text'])
      month.comments.create!(description: description, username: comment['username'], published_at: published_at)
    end
  end

  private

  def current_month
    year, month = Time.now.year, Time.now.month
    year * 100 + month
  end

  def format(comment)
    Rinku.auto_link(simple_format(sanitize(comment, tags: %w(strong em a p))))
  end
end
