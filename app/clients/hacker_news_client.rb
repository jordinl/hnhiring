require 'open-uri'
require 'json'

module HackerNewsClient
  def self.fetch_latest
    post = get_latest_hiring_post
    comments = get_comments(post['objectID'])
    {
      id: post.fetch('objectID'),
      created_at: post.fetch('created_at'),
      comments: comments.map { |comment| comment.symbolize_keys.slice(:id, :author, :created_at, :text) }
    }
  end

  private

  def self.get_latest_hiring_post
    get("search_by_date?tags=story,author_whoishiring").dig("hits", 0)
  end

  def self.get_comments(post_id)
    get("items/#{post_id}").dig("children")
  end

  def self.get(path)
    JSON.parse(open("https://hn.algolia.com/api/v1/#{path}").read)
  end
end
