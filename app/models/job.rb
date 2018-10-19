class Job < ActiveRecord::Base
  belongs_to :month, counter_cache: true, touch: true
  has_many :job_keywords, dependent: :destroy
  has_many :technologies, through: :job_keywords

  validates :month_id, :description, :published_at, :username, :api_id, presence: true

  scope :matching_text_sensitive, -> (text) { where('description ~ ?', text) }
  scope :matching_text, -> (text) { where('description ~* ?', text) }
  scope :matching_words, -> (words) do
    scope = nil
    words.each do |word|
      word_scope = matching_text('\y' + word + '\y')
      scope = scope ? scope.or(word_scope) : word_scope
    end
    scope
  end
end
