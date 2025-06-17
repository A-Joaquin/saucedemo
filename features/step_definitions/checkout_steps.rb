# Improved checkout steps with specific product validation

require_relative '../pages/checkout_page'

checkout_page = CheckoutPage.new

When('I proceed to checkout') do
  checkout_page.start_checkout
end

When('I fill checkout information with first name {string}, last name {string}, and postal code {string}') do |first_name, last_name, postal_code|
  checkout_page.fill_checkout_info(first_name, last_name, postal_code)
end

When('I continue to checkout overview') do
  checkout_page.continue_to_overview
end

When('I attempt to continue to checkout overview') do
  checkout_page.attempt_continue_to_overview
end

Then('I should see {string} in the checkout summary') do |product_name|
  expect(checkout_page.has_cart_item?(product_name)).to be true
end

Then('I should see the subtotal {string} for {int} item(s)') do |expected_subtotal, item_count|
  expect(checkout_page.cart_item_count).to eq(item_count)
  expect(checkout_page.subtotal_label).to include(expected_subtotal)
end

When('I complete the purchase') do
  checkout_page.finish_checkout
end

Then('I should see the order confirmation {string}') do |confirmation_message|
  expect(checkout_page.order_confirmation_message).to eq(confirmation_message)
end

Then('I should see all {int} products in the checkout summary:') do |expected_count, table|
  expect(checkout_page.cart_item_count).to eq(expected_count)
  table.raw.flatten.each do |product_name|
    expect(checkout_page.cart_item_names).to include(product_name)
  end
end

Then('the calculated subtotal should match the sum of individual prices') do
  expected_subtotal = checkout_page.individual_prices.sum
  actual_subtotal = checkout_page.subtotal_value
  expect(actual_subtotal).to eq(expected_subtotal)
end

Then('I should see the validation error {string}') do |error_message|
  expect(checkout_page.has_validation_error?(error_message)).to be true
end

Then('I should remain on the checkout information page') do
  expect(checkout_page.on_checkout_info_page?).to be true
end

When('I cancel the checkout process') do
  checkout_page.cancel_checkout
end

Then('the cart should still contain {int} item(s)') do |expected_count|
  badge = find('.shopping_cart_badge', wait: 5)
  actual_count = badge.text.to_i
  expect(actual_count).to eq(expected_count)
end

Then('the cart should contain {string}') do |product_name|
  checkout_page.open_cart
  expect(checkout_page.has_cart_product?(product_name)).to be true
  checkout_page.continue_shopping_if_possible
end