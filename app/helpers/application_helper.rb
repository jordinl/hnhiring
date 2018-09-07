module ApplicationHelper
  def default_title
    "Compilation of Hacker News 'Who is Hiring?' Posts"
  end

  def comment_timestamp(timestamp)
    timestamp < 24.hours.ago ? timestamp.to_date : time_ago_in_words(timestamp)
  end
end
