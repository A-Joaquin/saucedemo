Given('I am on the SauceDemo login page') do
  visit 'https://www.saucedemo.com/'
end

When('I enter username {string}') do |username|
  find('[data-test="username"]').set(username)
end

When('I enter password {string}') do |password|
  find('[data-test="password"]').set(password)
end

When('I enter valid credentials') do
  find('[data-test="username"]').set('standard_user')
  find('[data-test="password"]').set('secret_sauce')
end

When('I click the login button') do
  find('[data-test="login-button"]').click
end

Then('I should be redirected to the products page') do
  expect(page).to have_current_path(/inventory\.html/, url: true)
  expect(page).to have_css('.title', text: 'Products')
end

Then('I should see the error message {string}') do |msg|
  expect(page).to have_css('[data-test="error"]', text: msg)
end
