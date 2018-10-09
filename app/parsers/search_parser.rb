class SearchParser
  def call
    html = HTTParty.get("https://news.ycombinator.com/submitted?id=whoishiring").body
    link = Nokogiri::HTML.parse(html).css("td.title a").detect do |p|
      p.text.downcase =~ /^ask hn:.*hiring.*\(.*#{Time.now.strftime('%B').downcase[0,3]}.*#{Time.now.year}.*\)$/
    end

    link.attr("href").split("=")[1] if link
  end
end
