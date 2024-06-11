class ImportMonthService
  include ActionView::Helpers::SanitizeHelper

  def call
    attributes = HackerNewsClient.fetch_latest_hiring_post
    post = HiringPost.find_or_create_from_api(attributes)
    add_comments(post, attributes.fetch(:comments))

    attributes = HackerNewsClient.fetch_latest_freelancing_post
    post = FreelancerPost.find_or_create_from_api(attributes)
    add_comments(post, attributes.fetch(:comments))
  end

  private

  def add_comments(post, comments)
    comments.each do |html_comment|
      next if html_comment.fetch(:text).blank?
      comment = post.comments.find_or_initialize_by(api_id: html_comment.fetch(:id))
      comment.published_at ||= Time.parse(html_comment.fetch(:created_at))
      comment.username = html_comment.fetch(:author)
      comment.description = sanitize_description(html_comment.fetch(:text))
      comment.save! if comment.changed?
    end

    post.comments.where.not(api_id: comments.map { |c| c[:id] }).destroy_all
  end

  def sanitize_description(text)
    sanitize(text, tags: %w(strong em a p), attributes: %w(rel href))
  end
end
