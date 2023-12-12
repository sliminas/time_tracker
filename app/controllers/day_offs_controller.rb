# frozen_string_literal: true

class DayOffsController < ApplicationController
  def new
    @time = WorkingTime.new
  end

  def create
    day = Time.zone.parse working_time_params[:starts_at]

    @time = WorkingTime.new(
      starts_at: day + 8.hours,
      ends_at:   day + 16.5.hours
    )

    return redirect_to working_times_path if @time.save

    render :new
  end

  private

  def working_time_params
    params.permit!
    params[:working_time] || {}
  end
end
