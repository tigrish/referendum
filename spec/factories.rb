FactoryGirl.define do
  factory :proposal do |f|
    title 'Proposal Title'
    description 'Proposal Description'
    state 'open'
  end
  
  factory :user do |f|
    name 'John Doe'
    password 'sekrit'
    password_confirmation 'sekrit'
    sequence(:email) { |n| "user_#{n}@example.com" }
  end
  
  factory :vote do |f|
    value 1
  end
end