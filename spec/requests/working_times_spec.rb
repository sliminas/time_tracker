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

    context 'with tag_ids' do
      let(:tag1) { create :tag }
      let(:tag2) { create :tag }
      let(:tag_ids) { [tag1.id, tag2.id] }

      before { working_time.update tags: [tag1] }

      it 'adds tags' do
        patch working_time_path(working_time),
              params: { working_time: { tag_ids: } }

        expect(response).to redirect_to working_times_path
        expect(working_time.reload.tag_ids).to match_array(tag_ids)
      end

      it 'removes tags' do
        patch working_time_path(working_time),
              params: { working_time: { tag_ids: [tag2.id] } }

        expect(response).to redirect_to working_times_path
        expect(working_time.reload.tag_ids).to eq [tag2.id]
      end
    end
  end
end
