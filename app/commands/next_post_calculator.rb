class NextPostCalculator
  def call
    target_date = calculate_date + 11 * 3_600
    return target_date if Time.zone.now <= target_date
    calculate_date(target_date.next_month.beginning_of_month) + 11 * 3_600
  end

  private

  def calculate_date(target = Time.zone.now.beginning_of_month)
    return target + 2.days if target.saturday?
    return target + 1.day if target.sunday?
    target
  end
end
