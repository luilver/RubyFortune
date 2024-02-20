# frozen_string_literal: true

::FactoryBot.define do
  factory :option do
    poll
    text { Faker::Lorem.sentence }
  end
end
