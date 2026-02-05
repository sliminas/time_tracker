# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkingTime do
  describe '.balance' do
    include WorkingTimesHelper

    subject(:balance) { duration_to_hours_and_minutes described_class.balance }

    let(:monday) { Time.current.beginning_of_week }
    let(:starts_at) { monday }

    before { allow(Time).to receive(:current).and_return(monday.to_date) }

    context 'without working times' do
      it { is_expected.to eq "0min" }
    end

    context 'with finished working time' do
      let!(:working_time) do
        create(:working_time, starts_at:, ends_at: starts_at + worked_hours.hours)
      end

      context 'with less time than planned' do
        let(:worked_hours) { 5 }

        it { is_expected.to eq("-3h 12min") }
      end

      context 'with expected time' do
        let(:worked_hours) { 8.2 }

        it { is_expected.to eq("0min") }
      end

      context 'with overtime' do
        let(:worked_hours) { 10 }

        it { is_expected.to eq("1h 48min") }
      end

      context 'with working time on Tuesday of same week' do
        let(:tuesday) { monday + 1.day }

        before do
          create(:working_time, starts_at: tuesday, ends_at: tuesday + 7.hours)

          allow(Time).to receive(:current).and_return(tuesday.to_date)
        end

        context 'with less time than planned' do
          let(:worked_hours) { 5 }

          it { is_expected.to eq("-4h 24min") }
        end

        context 'with expected time' do
          let(:worked_hours) { 8.2 }

          it { is_expected.to eq("-1h 12min") }
        end

        context 'with overtime' do
          let(:worked_hours) { 11 }

          it { is_expected.to eq("1h 36min") }
        end
      end
    end

    context "with error" do
      let!(:monday1) do # 7:12
        create(:working_time,
               starts_at:Time.zone.local(2026, 2,2, 8,52),
               ends_at: Time.zone.local(2026, 2,2, 16,5))
      end
      let!(:monday2) do # 0:59
        create(:working_time,
               starts_at:Time.zone.local(2026, 2,2, 17,23),
               ends_at: Time.zone.local(2026, 2,2, 18,22))
      end
      let!(:tuesday1) do # 7:13
        create(:working_time,
               starts_at:Time.zone.local(2026, 2,3, 8,49),
               ends_at: Time.zone.local(2026, 2,3, 16,3))
      end
      # let!(:working_time4) do
      #   create(:working_time, starts_at:Time.zone.local(2026, 2,2, 17,1),
      #          ends_at: Time.zone.local(2026, 2,2, 18,2))
      # end
      before { allow(Time).to receive(:current).and_return(Time.zone.local(2026, 2,3)) }

      # worked = 7:12 + 0:59 + 7:13 = 15:24
      # supposed = 8:12 + 8:12 = 16:24
      # full week = 41
      # remaining for week = 41 - 15:24 = 25:36
      # balance tuesday = 15:24 - 8:12 - 8:12 = -1
      it { is_expected.to eq("-58min") }
    end
  end
end
