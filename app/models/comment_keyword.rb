class CommentKeyword < ActiveRecord::Base
  belongs_to :comment
  belongs_to :keyword, counter_cache: :comments_count
end
