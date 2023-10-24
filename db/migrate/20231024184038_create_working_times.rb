# frozen_string_literal: true

class CreateWorkingTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :working_times do |t|
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
