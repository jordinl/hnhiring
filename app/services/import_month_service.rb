class ImportMonthService
  include ActionView::Helpers::SanitizeHelper

  def call
    post = HackerNewsClient.fetch_latest_hiring_post
    post_date = Date.parse(post.fetch(:created_at))
    number = post_date.year * 100 + post_date.month
    @month ||= Month.find_or_create_by!(number: number, api_id: post.fetch(:id))

    post.fetch(:comments).each do |html_comment|
      next if html_comment.fetch(:text).blank?
      job = @month.jobs.find_or_initialize_by(api_id: html_comment.fetch(:id))
      job.published_at ||= Time.parse(html_comment.fetch(:created_at))
      job.username = html_comment.fetch(:author)
      job.description = sanitize_description(html_comment.fetch(:text))
      job.save! if job.changed?
    end
  end

  private

  def sanitize_description(text)
    sanitize(text, tags: %w(strong em a p), attributes: %w(rel href))
  end
end
