# frozen_string_literal: true

class WorkingTime < ApplicationRecord
  HOURS_PER_DAY  = ENV.fetch('HOURS_PER_DAY', 8.2).to_f
  DAYS_PER_WEEK  = ENV.fetch('DAYS_PER_WEEK', 5).to_f
  HOURS_PER_WEEK = HOURS_PER_DAY * DAYS_PER_WEEK

  has_many :tag_working_times, dependent: :destroy
  has_many :tags, through: :tag_working_times

  validates :starts_at, presence: true

  def self.balance
    worked_time = all.sum(&:duration)
    return 0 if worked_time.zero?

    week_day                 = [[Time.current.wday, DAYS_PER_WEEK].min, 1].max
    remaining_time_for_week = ((DAYS_PER_WEEK - week_day) * HOURS_PER_DAY) * 3600

    worked_time + remaining_time_for_week - supposed_time_until_end_of_week
  end

  def self.supposed_time_until_end_of_week
    (all.group_by(&:week_date).count * HOURS_PER_WEEK) * 3600
  end

  def ongoing?
    ends_at.nil?
  end

  def duration
    (ends_at || Time.current).to_i - starts_at.to_i
  end

  def week_date
    starts_at.beginning_of_week
  end

  def tag_with(name)
    tags.find_or_create_by(name:)
  end
end
