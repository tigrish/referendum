FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    expiry_seconds 60*60*24*7 # 1 week
    required_participation_percentage 20
  end

  factory :proposal do
    title 'Proposal Title'
    description 'Proposal Description'
    state 'open'
    association :category
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