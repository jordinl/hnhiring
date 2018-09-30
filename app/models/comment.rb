class Comment < ActiveRecord::Base
  belongs_to :month, counter_cache: true, touch: true

  validates :month_id, :description, :published_at, :username, :api_id, presence: true
end
