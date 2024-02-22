# frozen_string_literal: true

FactoryBot.define do
  factory :poll do
    title { Faker::Lorem.question }

    trait :with_options do
      after(:create) do |poll|
        create(:option, poll:)
      end
    end
  end
end
