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

    html_comments.each do |html_comment|
      comment = month.comments.find_or_initialize_by(api_id: html_comment['id'])
      comment.published_at ||= Chronic.parse(html_comment['date'])
      comment.username = html_comment['username']
      comment.description = format(html_comment['text'])
      comment.save! if comment.changed?
    end
  end

  private

  def current_month
    year, month = Time.now.year, Time.now.month
    year * 100 + month
  end

  def format(comment)
    Rinku.auto_link(simple_format(sanitize(comment, tags: %w(strong em a p)).gsub!("\n", '')))
  end
end
