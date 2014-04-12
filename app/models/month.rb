class Month < ActiveRecord::Base
  def post_id=(post_id)
    self.url = "https://news.ycombinator.com/item?id=#{post_id}"
  end

  def number=(number)
    month, year = number % 100, number / 100
    self.name = Date.new(year, month).strftime("%B")
    super
  end

  def comments
    @comments ||= []
    html = Nokogiri::HTML.parse(HTTParty.get(url).body)
    loop{
      @comments += html.css("td.default").map { |x| x.parent }.select do |x|
        (x.css("td img").first["width"] == "0") rescue nil
      end.map do |p|
        {
          "username" => p.css("span.comhead a").first.text,
          "text" => p.css("span.comment").first.to_html,
          "date" => p.css("span.comhead").first.children[1].text.gsub("|", "").strip
        } rescue nil
      end.compact

      if url = next_page(html)
        html = Nokogiri::HTML.parse(HTTParty.get(url).body)
      else
        return @comments.sort_by { |c| Chronic.parse(c["date"]) }.reverse
      end
    }
  end

  def next_page(html)
    link = html.css(".title a").detect { |x| x.text == "More" }
    "https://news.ycombinator.com#{link["href"]}" if link
  end
end
