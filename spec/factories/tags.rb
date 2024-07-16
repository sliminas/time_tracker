# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    sequence(:name) { "Tag #{_1}" }
  end
end
