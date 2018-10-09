class Job < ActiveRecord::Base
  belongs_to :month, counter_cache: true, touch: true

  validates :month_id, :description, :published_at, :username, :api_id, presence: true

  scope :with_description, -> (text) { where('description ILIKE ?', "%#{text}%")}
end
