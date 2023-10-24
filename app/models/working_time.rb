# frozen_string_literal: true

class WorkingTime < ApplicationRecord
  validates :starts_at, presence: true
end
