class JobKeyword < ActiveRecord::Base
  belongs_to :job
  belongs_to :technology, counter_cache: :jobs_count
end
