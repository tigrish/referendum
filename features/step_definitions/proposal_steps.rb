Given /^a user is logged in as "(.*)"$/ do |u|
  user = Factory(:user, :email => "#{u}@example.com")
  visit('/users/sign_in')
  fill_in('user[email]', :with => user.email)
  fill_in('user[password]', :with => 'sekrit')
  click_button("Create User")
  page.body.should =~ /Signed in/m 
end

Given /^an open proposal that has expired titled "([^"]*)"$/ do |title|
  proposal = Factory(:proposal, :title => title)
  proposal.update_attribute(:expires_at, Time.now - 1.day)
end
