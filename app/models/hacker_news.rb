class HackerNews
  class << self

    def get_last_hiring_post!
      return if Month.where(number: current_month).first

      if post_id = find_hiring_post
        Month.create(post_id: post_id, api_id: post_id, number: current_month)
      end
    end

    def current_month
      year, month = Time.now.year, Time.now.month
      year * 100 + month
    end

    def hiring_regex
      /^ask hn:.*hiring.*\(.*#{Time.now.strftime('%B').downcase[0,3]}.*#{Time.now.year}.*\)$/
    end

    def find_hiring_post
      html = open("https://news.ycombinator.com/submitted?id=whoishiring").read
      link = Nokogiri::HTML.parse(html).css("td.title a").detect do |p|
        p.text.downcase =~ /^ask hn:.*hiring.*\(.*#{Time.now.strftime('%B').downcase[0,3]}.*#{Time.now.year}.*\)$/
      end

      link.attr("href").split("=")[1] if link
    end
  end
end
