FactoryGirl.define do
  factory :message do
    content     { Faker::Lorem.sentence }
    user_id     { Faker::Number.number(1) }
    group_id    { Faker::Number.number(1) }
  end
end
