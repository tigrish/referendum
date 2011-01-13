FactoryGirl.define do
  factory :proposal do
    title 'Proposal Title'
    description 'Proposal Description'
    state 'open'
    association :user
  end
  
  factory :user do
    name 'John Doe'
    password 'sekrit'
    password_confirmation 'sekrit'
    sequence(:email) { |n| "user_#{n}@example.com" }
  end
  
  factory :vote do
    value 1
    association :user
    association :proposal
  end
end