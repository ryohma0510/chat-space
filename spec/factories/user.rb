FactoryGirl.define do
  factory :user do
    number = Faker::Number.number(8)
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              number
    password_confirmation number
  end

end
