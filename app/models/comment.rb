class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true, touch: true
  has_many :comment_keywords, dependent: :destroy
  has_many :keywords, through: :comment_keywords

  validates :post_id, :description, :published_at, :username, :api_id, presence: true

  scope :matching_text_sensitive, -> (text) { where('description ~ ?', text) }
  scope :matching_text, -> (text) { where('description ~* ?', text) }
  scope :not_matching_text, -> (text) { where('description !~* ?', text) }
  scope :matching_words, -> (words) do
    scope = nil
    words.each do |word|
      word_scope = matching_text('\y' + word + '\y')
      scope = scope ? scope.or(word_scope) : word_scope
    end
    scope
  end
  scope :not_matching_words, -> (words) do
    scope = nil
    words.each do |word|
      word_scope = not_matching_text('\y' + word + '\y')
      scope = scope ? scope.merge(word_scope) : word_scope
    end
    scope
  end
end
