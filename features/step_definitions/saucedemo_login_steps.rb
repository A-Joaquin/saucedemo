Given('I am on the SauceDemo login page') do
  visit 'https://www.saucedemo.com/'
end

When('I enter username {string}') do |username|
  fill_in 'user-name', with: username
end

When('I enter password {string}') do |password|
  fill_in 'password', with: password
end

When('I click the login button') do
  click_button 'Login'
end

Then('I should be redirected to the products page') do
  expect(page).to have_current_path(/inventory\.html/, url: true)
  expect(page).to have_content('Products')
end

Then('I should see the error message {string}') do |msg|
  expect(page).to have_css('[data-test="error"]', text: msg)
end
