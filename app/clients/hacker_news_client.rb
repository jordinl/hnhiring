require 'open-uri'
require 'json'

module HackerNewsClient
  def self.fetch_latest_hiring_post
    fetch_post('hiring')
  end

  def self.fetch_latest_freelancing_post
    fetch_post('freelancer')
  end

  private

  def self.fetch_post(query)
    post = search(query)
    comments = get_comments(post['objectID'])
    {
        id: post.fetch('objectID'),
        created_at: post.fetch('created_at'),
        comments: comments.map { |comment| comment.symbolize_keys.slice(:id, :author, :created_at, :text) }
    }
  end

  def self.get_comments(post_id)
    get("items/#{post_id}").dig('children')
  end

  def self.search(query)
    params = {
        tags: 'story,author_whoishiring',
        restrictSearchableAttributes: 'title',
        query: query
    }
    get("search_by_date?#{params.to_query}").dig('hits', 0)
  end

  def self.get(path)
    JSON.parse(URI.open("https://hn.algolia.com/api/v1/#{path}").read)
  end
end
