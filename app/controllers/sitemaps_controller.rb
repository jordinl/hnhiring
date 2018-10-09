class SitemapsController < ApplicationController
  layout false

  def show
    @months = Month.joins(:comments)
                .select(:id, :slug, 'max(comments.published_at) as published_at')
                .group(:id)
  end
end
