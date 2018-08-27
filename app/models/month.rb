class Month < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  has_many :comments

  def post_id=(post_id)
    self.url = "https://news.ycombinator.com/item?id=#{post_id}"
  end

  def number=(number)
    month, year = number % 100, number / 100
    self.name = Date.new(year, month).strftime("%B")
    super
  end

  def load_comments
    comments.destroy_all

    fetch_comments.each do |comment|
      published_at = Chronic.parse(comment['date'])
      description = Rinku.auto_link(simple_format(sanitize(comment['text'], tags: %w(strong em a p))))
      comments.create!(description: description, username: comment['username'], published_at: published_at)
    end
  end

  private

  def fetch_comments
    @comments ||= []
    html = Nokogiri::HTML.parse(HTTParty.get(url).body)
    loop{
      @comments += html.css("td.default").map { |x| x.parent }.select do |x|
        (x.css("td img").first["width"] == "0") rescue nil
      end.map do |p|
        {
          "username" => p.css(".hnuser").first.text,
          "text" => p.css(".comment .c00").first.to_html,
          "date" => p.css(".age").first.text.strip
        } rescue nil
      end.compact

      if url = next_page(html)
        html = Nokogiri::HTML.parse(HTTParty.get(url).body)
      else
        return @comments
      end
    }
  end

  def next_page(html)
    link = html.css(".title a").detect { |x| x.text == "More" }
    "https://news.ycombinator.com/#{link["href"]}" if link
  end
end
