# frozen_string_literal: true

module WorkingTimesHelper
  def duration_to_hours(duration)
    hours = duration.parts[:hours]
    minutes = duration.parts[:minutes]

    [
      ("#{hours}h" if hours),
      ("#{minutes}min" if minutes)
    ].compact.join(' ').presence || '0min'
  end
end
