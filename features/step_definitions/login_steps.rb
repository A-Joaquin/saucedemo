require_relative '../pages/login_page'

login_page = LoginPage.new

Given('I am on the SauceDemo login page') do
  login_page.visit_page
end

When('I enter username {string}') do |username|
  login_page.fill_username(username)
end

When('I enter password {string}') do |password|
  login_page.fill_password(password)
end

When('I enter valid credentials') do
  login_page.fill_valid_credentials
end

When('I click the login button') do
  login_page.click_login
end

Then('I should be redirected to the products page') do
  expect(login_page.on_products_page?).to be true
end

Then('I should see the error message {string}') do |msg|
  expect(login_page.has_error_message?(msg)).to be true
end
