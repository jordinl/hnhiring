class Month < ActiveRecord::Base
  validates :number, :api_id, presence: true
  validates :number, uniqueness: true

  has_many :jobs, dependent: :destroy

  before_create :set_slug

  def url
    return unless api_id
    @url ||= "https://news.ycombinator.com/item?id=#{api_id}"
  end

  def name
    @name ||= Date.new(year, month).strftime("%B")
  end

  def to_s
    "#{name} #{year}"
  end

  def short_name
    Date.new(year, month).strftime("%b %y")
  end

  def previous_month
    Month.order(number: :desc).where('number < ?', number).first
  end

  def month
    number % 100
  end

  def year
    number / 100
  end

  def to_param
    slug
  end

  def published_at
    jobs.order(:published_at).last.published_at
  end

  private

  def set_slug
    self.slug = "#{Date::MONTHNAMES[month].downcase}-#{year}"
  end
end
