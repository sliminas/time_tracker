# frozen_string_literal: true

class CreateTagsWorkingTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :tag_working_times do |t|
      t.belongs_to :tag, null: false, foreign_key: true
      t.belongs_to :working_time, null: false, foreign_key: true
      t.index %i[tag_id working_time_id], unique: true

      t.timestamps
    end
  end
end
