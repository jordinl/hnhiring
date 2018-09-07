class HackerNews
  class << self
    def get_last_hiring_post!
      month = Month.where(number: current_month).first

      if month.nil? && post_id = SearchParser.new.call
        month = Month.create(post_id: post_id, api_id: post_id, number: current_month)
      end

      month.load_comments if month.present?
    end

    def current_month
      year, month = Time.now.year, Time.now.month
      year * 100 + month
    end
  end
end
