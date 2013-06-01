require 'open-uri'

class HackerNews
  class << self

    def get_last_hiring_post!
      return if Month.where(number: current_month).first
      Month.create(post_id: @post['id'], api_id: @post['_id'], number: current_month) if @post = find_hiring_post
    end

    def current_month
      year, month = Time.now.year, Time.now.month
      year * 100 + month
    end

    def search_url
      "http://api.thriftdb.com/api.hnsearch.com/items/_search?limit=10&sortby=score+desc&weights[title]=1.1&weights[text]=0.7&weights[domain]=2&weights[username]=0.1&weights[type]=0&boosts[fields][points]=0.15&boosts[fields][num_comments]=0.15&boosts[functions][pow%282%2Cdiv%28div%28ms%28create_ts%2CNOW%29%2C3600000%29%2C72%29%29]=200&q=hiring&facet[queries][]=username%3Ahiring&_=#{Time.now.to_i}"
    end

    def search_results
      JSON.parse(open(search_url).read)['results']
    end

    def hiring_regex
      /^ask hn:.*hiring.*\(.*#{Time.now.strftime('%B').downcase[0,3]}.*#{Time.now.year}.*\)$/
    end

    def find_hiring_post
      posts = search_results.map{ |r| r['item'] }.select{ |r| r['title'] }
      posts.select { |p| p['title'].downcase =~ hiring_regex }.first
    end

  end
end
