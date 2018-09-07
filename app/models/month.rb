class Month < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  validates :number, :api_id, presence: true
  validates :number, uniqueness: true

  has_many :comments, dependent: :destroy

  def url
    "https://news.ycombinator.com/item?id=#{api_id}"
  end

  def previous_month
    Month.order(number: :desc).where('number < ?', number).first
  end

  def number=(number)
    month, year = number % 100, number / 100
    self.name = Date.new(year, month).strftime("%B")
    super
  end

  def year
    number / 100
  end

  def load_comments
    comments.destroy_all

    html_comments = CommentsParser.new(url).call

    html_comments.each do |comment|
      published_at = Chronic.parse(comment['date'])
      description = Rinku.auto_link(simple_format(sanitize(comment['text'], tags: %w(strong em a p))))
      comments.create!(description: description, username: comment['username'], published_at: published_at)
    end
  end
end
