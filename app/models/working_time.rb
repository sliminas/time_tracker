# frozen_string_literal: true

class WorkingTime < ApplicationRecord
  validates :starts_at, presence: true

  def duration
    ActiveSupport::Duration.build((ends_at || Time.current) - starts_at)
  end
end
