class HackerNews
  class << self

    def get_last_hiring_post!
      month = Month.where(number: current_month).first

      if month.nil? && post_id = find_hiring_post
        month = Month.create(post_id: post_id, api_id: post_id, number: current_month)
      end

      month.load_comments if month.present?
    end

    def current_month
      year, month = Time.now.year, Time.now.month
      year * 100 + month
    end

    def hiring_regex
      /^ask hn:.*hiring.*\(.*#{Time.now.strftime('%B').downcase[0,3]}.*#{Time.now.year}.*\)$/
    end

    def find_hiring_post
      html = HTTParty.get("https://news.ycombinator.com/submitted?id=whoishiring").body
      link = Nokogiri::HTML.parse(html).css("td.title a").detect do |p|
        p.text.downcase =~ /^ask hn:.*hiring.*\(.*#{Time.now.strftime('%B').downcase[0,3]}.*#{Time.now.year}.*\)$/
      end

      link.attr("href").split("=")[1] if link
    end
  end
end
