# frozen_string_literal: true

class WorkingTimesController < ApplicationController
  def index
    @latest_time = WorkingTime.order(starts_at: :desc).first
    @times = WorkingTime.order(starts_at: :desc)
  end

  def new
    @time = WorkingTime.new
  end

  def create
    @time = WorkingTime.new(params.require(:working_time).permit(:starts_at, :ends_at))

    return redirect_to working_times_path if @time.save

    render :new
  end

  def update
    @time = WorkingTime.find(params[:id])
    @time.update(params.require(:working_time).permit(:ends_at))

    redirect_to working_times_path
  end

  def destroy
    @time = WorkingTime.find(params[:id])
    @time.destroy

    redirect_to working_times_path
  end
end
