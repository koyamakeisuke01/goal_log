FactoryBot.define do
  factory :task do
    title {Faker::Lorem.sentence}
    association :user
  end
end
