class DescriptionFormatter
  include ActionView::Helpers::SanitizeHelper

  def self.call(text)
    new(text).call
  end

  def initialize(text)
    @text = text
  end

  def call
    sanitized = sanitize(@text, tags: %w(strong em a p), attributes: %w(rel href))
    html = ''
    paragraph = ''
    Nokogiri::HTML.fragment(sanitized).children.each do |node|
      if node.name == 'p'
        html << '<p>' + paragraph + '</p>'
        html << node.to_s
        paragraph = ''
      else
        paragraph += node.to_s
      end
    end
    html << '<p>' + paragraph + '</p>'
    html.squish!.gsub(/<p>\s*<\/p>/, '')
  end
end
