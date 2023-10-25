# frozen_string_literal: true

module WorkingTimesHelper
  def relative_week(date)
    weeks = ActiveSupport::Duration.build(
      Time.current.beginning_of_week - date.beginning_of_week
    ).parts[:weeks]

    case weeks
    when nil
      'This week'
    when 1
      'Last week'
    when 2
      'Two weeks ago'
    else
      "Week #{date.strftime('%W')}"
    end + " / #{date.to_fs(:date)}"
  end

  def summed_duration_to_hours(week_times)
    duration_to_hours week_times.sum(&:duration)
  end

  def duration_to_hours(duration)
    unless duration.is_a?(ActiveSupport::Duration)
      duration = ActiveSupport::Duration.build(duration)
    end

    hours = duration.parts[:hours]
    minutes = duration.parts[:minutes]

    [
      ("#{hours}h" if hours),
      ("#{minutes}min" if minutes)
    ].compact.join(' ').presence || '0min'
  end
end
