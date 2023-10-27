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

  def duration_to_hours_and_minutes(seconds)
    duration = to_duration(seconds)
    hours    = duration.in_hours.floor
    minutes  = (duration.in_minutes % 60).floor

    [
      ("#{hours}h" if hours.positive?),
      ("#{minutes}min" if minutes.positive?)
    ].compact.join(' ').presence || '0min'
  end

  def week_duration_background(seconds)
    hours_per_week = WorkingTime::HOURS_PER_WEEK

    case to_duration(seconds).in_hours
    when 0..(hours_per_week - 1)
      'bg-warning'
    when (hours_per_week - 1)..(hours_per_week + 1)
      'bg-success'
    else
      'bg-danger'
    end
  end

  private

  def to_duration(seconds)
    ActiveSupport::Duration.build(seconds)
  end
end
