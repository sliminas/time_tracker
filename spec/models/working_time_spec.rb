# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkingTime do
  describe '.balance' do
    subject(:balance) { described_class.balance / 1.hour }

    let(:monday) { Time.current.beginning_of_week }
    let(:starts_at) { monday }

    before { allow(Date).to receive(:current).and_return(monday.to_date) }

    context 'without working times' do
      it { is_expected.to eq 0 }
    end

    context 'with finished working time' do
      let!(:working_time) do
        create(:working_time, starts_at:, ends_at: starts_at + worked_hours.hours)
      end

      context 'with less time than planned' do
        let(:worked_hours) { 5 }

        it { is_expected.to eq(-3.5) }
      end

      context 'with expected time' do
        let(:worked_hours) { 8.5 }

        it { is_expected.to eq(0) }
      end

      context 'with overtime' do
        let(:worked_hours) { 10 }

        it { is_expected.to eq(1.5) }
      end

      context 'with working time on Tuesday of same week' do
        let(:tuesday) { monday + 1.day }

        before do
          create(:working_time, starts_at: tuesday, ends_at: tuesday + 7.hours)

          allow(Date).to receive(:current).and_return(tuesday.to_date)
        end

        context 'with less time than planned' do
          let(:worked_hours) { 5 }

          it { is_expected.to eq(-5) }
        end

        context 'with expected time' do
          let(:worked_hours) { 8.5 }

          it { is_expected.to eq(-1.5) }
        end

        context 'with overtime' do
          let(:worked_hours) { 11 }

          it { is_expected.to eq(1) }
        end
      end
    end
  end
end
