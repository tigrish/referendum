Factory.define :proposal do |f|
  f.title 'Proposal Title'
  f.description 'Proposal Description'
  f.user { Factory(:user) }
  f.state 'open'
end

Factory.define :user do |f|
  f.name 'John Doe'
  f.password 'sekrit'
  f.password_confirmation 'sekrit'
  f.sequence(:email) {|n| "user_#{n}@example.com" }
end

Factory.define :vote do |f|
  f.value 1
  f.proposal { Factory(:proposal) }
  f.user { Factory(:user) }
end