class CommentKeyword < ActiveRecord::Base
  belongs_to :comment
  belongs_to :keyword
end
