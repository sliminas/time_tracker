# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkingTimesController do
  describe '#update' do
    let(:working_time) { create :working_time, :unfinished }

    it 'finishes unfinished working time' do
      freeze_time

      patch working_time_path(working_time)

      expect(response).to redirect_to working_times_path

      expect(working_time.reload.ends_at).to eq Time.current
    end
  end
end
