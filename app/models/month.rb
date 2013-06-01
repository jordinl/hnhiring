require "open-uri"

class Month < ActiveRecord::Base
  def post_id=(post_id)
    self.url = "http://news.ycombinator.com/item?id=#{post_id}"
  end

  def number=(number)
    month, year = number % 100, number / 100
    self.name = Date.new(year, month).strftime("%B")
    super
  end

  def post_url(start = 0)
    "http://api.thriftdb.com/api.hnsearch.com/items/_search?filter[fields][parent_sigid][]=#{api_id}&limit=100&sortby=create_ts+desc&start=#{start}"
  end

  def comments
    @comments ||= []
    return @comments unless @comments.empty?
    start = 0
    loop{
      response = open(post_url(start)).read
      comments = JSON.parse(response)['results'].map{ |r| r['item'] }
      @comments += comments
      return @comments if comments.length < 100
      start += 100
    }
  end
end
