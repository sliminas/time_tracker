# frozen_string_literal: true

class WorkingTime < ApplicationRecord
  HOURS_PER_DAY  = 8.5
  DAYS_PER_WEEK  = 4
  HOURS_PER_WEEK = HOURS_PER_DAY * DAYS_PER_WEEK

  validates :starts_at, presence: true

  def self.balance
    worked_hours = all.sum(&:duration)
    return 0 if worked_hours.zero?

    supposed_hours_full_week = all.group_by(&:week_date).count * HOURS_PER_WEEK.hours
    remaining_hours_for_current_week = (DAYS_PER_WEEK - Date.current.wday) * HOURS_PER_DAY.hours

    worked_hours - supposed_hours_full_week + remaining_hours_for_current_week
  end

  def duration
    (ends_at || Time.current) - starts_at
  end

  def week_date
    starts_at.beginning_of_week
  end
end
