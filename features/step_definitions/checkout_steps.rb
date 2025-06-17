# Improved checkout steps with specific product validation

When('I proceed to checkout') do
  find('.shopping_cart_link', wait: 5).click
  expect(page).to have_selector('.cart_contents_container', wait: 5)
  find('#checkout', wait: 5).click
  expect(page).to have_current_path(/checkout-step-one.html/, url: true)
end

When('I fill checkout information with first name {string}, last name {string}, and postal code {string}') do |first_name, last_name, postal_code|
  fill_in 'first-name', with: first_name
  fill_in 'last-name', with: last_name
  fill_in 'postal-code', with: postal_code
end

When('I continue to checkout overview') do
  find('#continue', wait: 5).click
  expect(page).to have_current_path(/checkout-step-two.html/, url: true)
end

When('I attempt to continue to checkout overview') do
  find('#continue', wait: 5).click
  # No verificamos redirección aquí, eso lo hace el Then
end

Then('I should see {string} in the checkout summary') do |product_name|
  within('.cart_list') do
    expect(page).to have_selector('.inventory_item_name', text: product_name, wait: 5)
  end
end

Then('I should see the subtotal {string} for {int} item(s)') do |expected_subtotal, item_count|
  actual_items = all('.cart_item').count
  expect(actual_items).to eq(item_count), 
    "Expected #{item_count} items in summary, but found #{actual_items}"
  
  subtotal_text = find('.summary_subtotal_label', wait: 5).text
  expect(subtotal_text).to include(expected_subtotal)
end

When('I complete the purchase') do
  find('#finish', wait: 5).click
  expect(page).to have_current_path(/checkout-complete.html/, url: true)
end

Then('I should see the order confirmation {string}') do |confirmation_message|
  expect(page).to have_selector('.complete-header', text: confirmation_message, wait: 5)
end

Then('I should see all {int} products in the checkout summary:') do |expected_count, table|
  actual_items = all('.cart_item').count
  expect(actual_items).to eq(expected_count)
  
  table.raw.flatten.each do |product_name|
    within('.cart_list') do
      expect(page).to have_selector('.inventory_item_name', text: product_name, wait: 5)
    end
  end
end

Then('the calculated subtotal should match the sum of individual prices') do
  individual_prices = all('.inventory_item_price').map do |price_element|
    price_text = price_element.text.gsub('$', '').to_f
    price_text
  end
  
  expected_subtotal = individual_prices.sum
  
  subtotal_text = find('.summary_subtotal_label', wait: 5).text
  actual_subtotal = subtotal_text.match(/\$(\d+\.\d+)/)[1].to_f
  
  expect(actual_subtotal).to eq(expected_subtotal), 
    "Expected subtotal #{expected_subtotal}, but found #{actual_subtotal}"
end

Then('I should see the validation error {string}') do |error_message|
  expect(page).to have_selector('[data-test="error"]', text: error_message, wait: 5)
end

Then('I should remain on the checkout information page') do
  expect(page).to have_current_path(/checkout-step-one.html/, url: true)
  expect(page).to have_content('Checkout: Your Information')
end

When('I cancel the checkout process') do
  find('#cancel', wait: 5).click
end

Then('the cart should still contain {int} item(s)') do |expected_count|
  badge = find('.shopping_cart_badge', wait: 5)
  actual_count = badge.text.to_i
  expect(actual_count).to eq(expected_count)
end

Then('the cart should contain {string}') do |product_name|
  find('.shopping_cart_link', wait: 5).click
  within('.cart_contents_container') do
    expect(page).to have_selector('.inventory_item_name', text: product_name, wait: 5)
  end
  # Regresar a productos para el siguiente step
  find('#continue-shopping', wait: 5).click if page.has_selector?('#continue-shopping')
end