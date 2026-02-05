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
    hours    = duration.in_hours.abs.floor
    minutes  = (duration.in_minutes.abs % 60).floor

    prefix = duration.negative? && !(minutes.zero? && hours.zero?) ? '-' : ''
    [
      ("#{hours}h" unless hours.zero?),
      ("#{minutes}min" if minutes.positive?)
    ].compact.join(' ').prepend(prefix).presence || '0min'
  end

  def week_duration_background(seconds)
    hours_per_week = WorkingTime::HOURS_PER_WEEK

    case to_duration(seconds).in_hours
    when ..(hours_per_week - 2)
      'bg-yellow-400'
    when ((hours_per_week + 2)..)
      'bg-red-500'
    else
      'bg-lime-500'
    end
  end

  private

  def to_duration(seconds)
    ActiveSupport::Duration.build(seconds)
  end
end
