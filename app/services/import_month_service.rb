class ImportMonthService
  def initialize(month = nil)
    @month = month
  end

  def call
    @month ||= Month.find_or_create_by!(number: current_month, api_id: api_id)

    html_comments = CommentsParser.new(@month.url).call

    html_comments.each do |html_comment|
      comment = @month.comments.find_or_initialize_by(api_id: html_comment['id'])
      comment.published_at ||= Chronic.parse(html_comment['date'])
      comment.username = html_comment['username']
      comment.description = DescriptionFormatter.call(html_comment['text'])
      comment.save! if comment.changed?
    end
  end

  private

  def current_month
    year, month = Time.now.year, Time.now.month
    year * 100 + month
  end

  def api_id
    SearchParser.new.call
  end
end
