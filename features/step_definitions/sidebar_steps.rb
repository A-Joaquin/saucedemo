require_relative '../pages/sidebar_page'

sidebar_page = SidebarPage.new

When('I open the sidebar menu') do
  sidebar_page.open_sidebar
end

When('I click {string} in the sidebar') do |link_text|
  sidebar_page.click_sidebar_link(link_text)
end

When('I close the sidebar menu') do
  sidebar_page.close_sidebar
end

Then('the sidebar menu should be closed') do
  expect(sidebar_page.sidebar_closed?).to be true
end

Then(/^the sidebar menu should be closed \(or not present on login page\)$/) do
  expect(sidebar_page.sidebar_closed_on_login_page?).to be true
end

Then('I should be redirected to the {string} page') do |expected_url|
  expect(sidebar_page.redirected_to?(expected_url)).to be true
  case expected_url
  when /saucelabs\.com/
    expect(sidebar_page.on_saucelabs_page?).to be true
  when /inventory\.html/
    expect(sidebar_page.on_inventory_page?).to be true
  end
end

When('I add the first product to the cart from the products page') do
  expect(page).to have_current_path(/inventory.html/, url: true)
  add_button = first('.inventory_item .btn_primary.btn_inventory', wait: 5)
  expect(add_button).not_to be_nil, "No 'Add to cart' button found on the products page."
  add_button.click
  expect(page).to have_selector('.shopping_cart_badge', text: '1', wait: 5)
end

Then('the cart should be empty') do
  expect(page).not_to have_selector('.shopping_cart_badge', wait: 5)
end