# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :tag_working_times, dependent: :destroy
  has_many :working_times, through: :tag_working_times
end
