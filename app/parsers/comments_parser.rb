class CommentsParser
  def initialize(url)
    @url = url
  end

  def call
    comments = []
    html = Nokogiri::HTML.parse(HTTParty.get(@url).body)
    loop{
      comments += html.css("td.default").map { |x| x.parent }.select do |x|
        (x.css("td img").first["width"] == "0") rescue nil
      end.map do |p|
        {
          "username" => p.css(".hnuser").first.text,
          "text" => p.css(".comment .c00").first.to_html,
          "date" => p.css(".age").first.text.strip,
          "id" => p.css(".age a").first['href'].split('=')[1]
        } rescue nil
      end.compact

      if url = next_page(html)
        html = Nokogiri::HTML.parse(HTTParty.get(url).body)
      else
        return comments
      end
    }
  end

  def next_page(html)
    link = html.css(".title a").detect { |x| x.text == "More" }
    "https://news.ycombinator.com/#{link["href"]}" if link
  end
end
