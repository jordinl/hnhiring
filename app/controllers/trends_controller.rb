class TrendsController < ApplicationController
  helper_method :trends_technologies, :trends_locations

  def show
    @technologies = Keyword.technology.order(jobs_count: :desc)
    @technologies.limit!(10) if trends_technologies.empty?
    @technologies.where!(slug: trends_technologies) if trends_technologies.any?
    @locations = Keyword.location.where(slug: trends_locations) if trends_locations.any?
    @posts    = HiringPost.order(number: :asc)

    @counts = Keyword.technology.left_joins(:comments)
                .group('comments.post_id', :id)
                .select('keywords.*, comments.post_id, count(comments) as count')
                .where(id: @technologies)

    if @locations
      @counts.merge!(
        Comment.where(id: Comment.joins(:comment_keywords)
                                 .merge(CommentKeyword.where(keyword_id: @locations))))
    end
  end

  private

  def trends_technologies
    @trends_technologies ||= params[:technologies].present? ? params[:technologies].split(',') : []
  end

  def trends_locations
    @trends_locations ||= params[:locations].present? ? params[:locations].split(',') : []
  end
end
