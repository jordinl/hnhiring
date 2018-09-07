class Comment < ActiveRecord::Base
  belongs_to :month, counter_cache: true
end
