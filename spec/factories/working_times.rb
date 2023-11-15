# frozen_string_literal: true

FactoryBot.define do
  factory :working_time do
    starts_at { 1.hour.ago }

    trait :unfinished do
      ends_at { nil }
    end

    trait :finished do
      ends_at { 1.minute.ago }
    end
  end
end
