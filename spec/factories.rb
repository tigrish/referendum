Factory.define :user do |f|
  f.name 'John Doe'
  f.email 'user@example.com'
  f.password 'sekrit'
  f.password_confirmation 'sekrit'
end