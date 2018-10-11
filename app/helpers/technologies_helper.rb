module TechnologiesHelper
  def technology_name(technology)
    t(technology.slug, scope: :technologies, default: technology.slug.titleize)
  end
end
