class CommentKeyword < ActiveRecord::Base
  belongs_to :job
  belongs_to :keyword, counter_cache: :jobs_count
end
