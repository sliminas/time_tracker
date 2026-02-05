# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkingTimesHelper do
  describe '#duration_to_hours_and_minutes' do
    subject(:formatted_duration) { duration_to_hours_and_minutes(duration) }

    context 'with only seconds' do
      let(:duration) { 59.seconds }
      it { is_expected.to eq '0min' }
    end

    context 'with full minutes' do
      let(:duration) { 3.minutes }
      it { is_expected.to eq '3min' }
    end

    context 'with minutes and seconds' do
      let(:duration) { 140.seconds }
      it { is_expected.to eq '2min' }
    end

    context 'with full hours' do
      let(:duration) { 60.minutes }
      it { is_expected.to eq '1h' }
    end

    context 'with hours and minutes' do
      let(:duration) { 140.minutes }
      it { is_expected.to eq '2h 20min' }
    end

    context 'with hours and minutes' do
      let(:duration) { -3480.0 }
      it { is_expected.to eq '-58min' }
    end

    context 'with negative duration' do
      let(:duration) { -140.minutes }
      it { is_expected.to eq '-2h 20min' }
    end
  end

  describe '#relative_week' do
    subject(:formatted_week) { relative_week(date) }

    context 'with this week' do
      let(:date) { Time.current }
      it { is_expected.to eq "This week / #{date.to_fs(:date)}" }
    end

    context 'with last week' do
      let(:date) { 1.week.ago }
      it { is_expected.to eq "Last week / #{date.to_fs(:date)}" }
    end

    context 'with more than 1 week ago' do
      let(:date) { 2.weeks.ago }
      it { is_expected.to eq "Two weeks ago / #{date.to_fs(:date)}" }
    end

    context 'with more than 2 weeks ago' do
      let(:date) { 3.weeks.ago }
      it { is_expected.to eq "Week #{date.strftime('%W')} / #{date.to_fs(:date)}" }
    end

    context 'with 1 year ago' do
      let(:date) { 3.weeks.ago }
      it { is_expected.to eq "Week #{date.strftime('%W')} / #{date.to_fs(:date)}" }
    end
  end
end
