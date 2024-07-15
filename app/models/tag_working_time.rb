# frozen_string_literal: true

class TagWorkingTime < ApplicationRecord
  belongs_to :tag
  belongs_to :working_time

  validates :tag_id, uniqueness: { scope: :working_time_id }
end
