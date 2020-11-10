class SitemapsController < ApplicationController
  layout false

  def show
    @posts = HiringPost.joins(:comments)
                .select(:id, :slug, 'max(comments.published_at) as max_published_at')
                .group(:id)

    @locations = Keyword.location.joins(:comment_keywords)
                   .select(:id, :slug, 'max(comment_keywords.created_at) as updated_at')
                   .group(:id)

    @technologies = Keyword.technology.joins(:comment_keywords)
                      .select(:id, :slug, 'max(comment_keywords.created_at) as updated_at')
                      .group(:id)
  end
end
