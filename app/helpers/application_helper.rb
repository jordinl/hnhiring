module ApplicationHelper
  def default_title
    "All Jobs From Hacker News 'Who is Hiring?' Posts"
  end

  def job_timestamp(timestamp)
    timestamp < 24.hours.ago ? timestamp.to_date : "#{time_ago_in_words(timestamp)} ago"
  end

  def external_link(title, url)
    link_to(title, url, target: '_blank', rel: 'noopener noreferrer')
  end
end
