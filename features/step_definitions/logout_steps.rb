require_relative '../pages/sidebar_page'
require_relative '../pages/login_page'

sidebar_page = SidebarPage.new
login_page = LoginPage.new

When('I open the menu') do
  sidebar_page.open_sidebar
end

When('I click the logout button') do
  sidebar_page.click_sidebar_link('Logout')
end

Then('I should be redirected to the login page') do
  expect(page).to have_selector('input[type="submit"][value="Login"]', wait: 5)
end

When('I try to visit the products page directly') do
  visit 'https://www.saucedemo.com/inventory.html'
end