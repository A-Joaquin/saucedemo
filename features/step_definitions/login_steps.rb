require_relative '../pages/login_page'
require_relative '../support/test_data'

login_page = LoginPage.new

Given('I am on the SauceDemo login page') do
  login_page.load
end

When('I enter username {string}') do |username|
  login_page.fill_username(username)
end

When('I enter password {string}') do |password|
  login_page.fill_password(password)
end

When('I enter valid credentials') do
  login_page.fill_username(TestData::VALID_USERNAME)
  login_page.fill_password(TestData::VALID_PASSWORD)
end

When('I click the login button') do
  login_page.click_login
end

Then('I should be redirected to the products page') do
  expect(page).to have_current_path(LoginPage::PRODUCTS_PATH, url: true, wait: 5)
  expect(page).to have_css(LoginPage::PRODUCTS_TITLE, text: 'Products', wait: 5)
end

Then('I should see the error message {string}') do |msg|
  expect(page).to have_css(LoginPage::ERROR_MESSAGE, text: msg, wait: 5)
end
