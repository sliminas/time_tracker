# frozen_string_literal: true

class WorkingTime < ApplicationRecord
  HOURS_PER_WEEK = 32

  validates :starts_at, presence: true

  def duration
    (ends_at || Time.current) - starts_at
  end
end
