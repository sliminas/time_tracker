# frozen_string_literal: true

class WorkingTime < ApplicationRecord
  HOURS_PER_DAY  = 8.2
  DAYS_PER_WEEK  = 4
  HOURS_PER_WEEK = HOURS_PER_DAY * DAYS_PER_WEEK

  has_many :tag_working_times, dependent: :destroy
  has_many :tags, through: :tag_working_times

  validates :starts_at, presence: true

  def self.balance
    worked_hours = all.sum(&:duration)
    return 0 if worked_hours.zero?

    supposed_hours_full_week         = all.group_by(&:week_date).count * HOURS_PER_WEEK.hours
    week_day                         = [Date.current.wday, 4].min
    remaining_hours_for_current_week = (DAYS_PER_WEEK - week_day) * HOURS_PER_DAY.hours

    worked_hours - supposed_hours_full_week + remaining_hours_for_current_week
  end

  def ongoing?
    ends_at.nil?
  end

  def duration
    (ends_at || Time.current) - starts_at
  end

  def week_date
    starts_at.beginning_of_week
  end

  def tag_with(name)
    tags.find_or_create_by(name:)
  end
end
