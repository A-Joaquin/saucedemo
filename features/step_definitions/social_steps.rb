Given('I scroll to the footer') do
  page.execute_script("window.scrollTo(0, document.body.scrollHeight)")
end

Given('I can see the social media icons') do
  expect(page).to have_selector('.social')
  expect(page).to have_selector('[data-test="social-facebook"]')
end

When('I click on the Facebook icon') do
  @current_window = page.current_window
  click_link('Facebook')
end

Then('a new tab should open') do
  expect(page.windows.length).to be > 1
  @new_window = (page.windows - [@current_window]).last
  page.switch_to_window(@new_window)
end

Then('the Facebook URL should be {string}') do |url|
  expect(page.current_url).to eq(url)
end

Then('the Facebook page title should contain {string}') do |title|
  expect(page.title).to include(title)
end