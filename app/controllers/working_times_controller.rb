# frozen_string_literal: true

class WorkingTimesController < ApplicationController
  def index
    @latest_time = WorkingTime.order(starts_at: :desc).first
    @times = WorkingTime.order(starts_at: :desc)
                        .group_by { _1.starts_at.beginning_of_week }
                        .transform_values do |week_working_times|
      week_working_times.group_by { |working_time| working_time.starts_at.beginning_of_day }
    end
  end

  def new
    @time = WorkingTime.new
  end

  def create
    @time = WorkingTime.new(
      starts_at: working_time_params[:starts_at] || Time.current,
      ends_at:   working_time_params[:ends_at]
    )

    return redirect_to working_times_path if @time.save

    render :new
  end

  def update
    @time = WorkingTime.find(params[:id])
    @time.update(ends_at: working_time_params[:ends_at] || Time.current)

    redirect_to working_times_path
  end

  def destroy
    @time = WorkingTime.find(params[:id])
    @time.destroy

    redirect_to working_times_path
  end

  private

  def working_time_params
    params.permit!
    params[:working_time] || {}
  end
end
