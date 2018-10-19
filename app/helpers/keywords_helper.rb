module KeywordsHelper
  def keyword_name(keyword)
    t(keyword.slug, scope: keyword.kind, default: keyword.slug.titleize)
  end
end
