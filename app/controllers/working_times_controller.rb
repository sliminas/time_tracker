# frozen_string_literal: true

class WorkingTimesController < ApplicationController
  def index
    WorkingTime.order(starts_at: :desc)
  end
end
