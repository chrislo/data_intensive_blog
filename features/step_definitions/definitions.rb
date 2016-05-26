When(/^I add a new post to the blog$/) do
  visit '/post/new'
  fill_in("body", with: "A new post to the blog")
  click_button("Post")
end

Then(/^I should see the post on the homepage$/) do
  visit '/'
  expect(body).to match(/A new post to the blog/)
end
