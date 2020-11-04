class ImportMonthService
  include ActionView::Helpers::SanitizeHelper

  def call
    post = HackerNewsClient.fetch_latest_hiring_post
    post_date = Date.parse(post.fetch(:created_at))
    number = post_date.year * 100 + post_date.month
    @post ||= Post.find_or_create_by!(number: number, api_id: post.fetch(:id))

    post.fetch(:comments).each do |html_comment|
      next if html_comment.fetch(:text).blank?
      comment = @post.comments.find_or_initialize_by(api_id: html_comment.fetch(:id))
      comment.published_at ||= Time.parse(html_comment.fetch(:created_at))
      comment.username = html_comment.fetch(:author)
      comment.description = sanitize_description(html_comment.fetch(:text))
      comment.save! if comment.changed?
    end
  end

  private

  def sanitize_description(text)
    sanitize(text, tags: %w(strong em a p), attributes: %w(rel href))
  end
end
