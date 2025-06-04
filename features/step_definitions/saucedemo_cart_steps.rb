When('I click on the add to cart button for {string}') do |item_name|
  find(:xpath, "//div[text()='#{item_name}']/ancestor::div[@class='inventory_item']//button[contains(text(), 'Add to cart')]").click
end

When('I click the remove button') do
  click_button('Remove')
end

When('I click on the cart title {string}') do |product_name|
  find('.inventory_item_name', text: product_name).click
end

Then('the button should change to {string}') do |button_text|
  expect(page).to have_button(button_text, wait: 5)
end

Then('the cart badge should be empty') do
  expect(page).not_to have_css('.shopping_cart_badge', wait: 5)
end

Then('I should see detailed cart information') do
  expect(page).to have_css('.inventory_details_desc', wait: 5)
  expect(page).to have_css('.inventory_details_price', wait: 5)
end

Then('I should see the cart details page for {string}') do |product_name|
  expect(page).to have_css('.inventory_details_name', text: product_name, wait: 5)
end

Then('the cart badge should show {string}') do |expected_count|
  expect(page).to have_css('.shopping_cart_badge', text: expected_count, wait: 5)
end

Given('I have added {string} to the cart') do |product_name|
  step "I click on the add to cart button for \"#{product_name}\""
end

When('I add the first product {string} to the cart') do |expected_product_name|
  first_product_element = find('.inventory_item:first-child', wait: 5)
  actual_product_name = first_product_element.find('.inventory_item_name').text
  
  expect(actual_product_name).to eq(expected_product_name), 
    "Expected first product to be '#{expected_product_name}', but found '#{actual_product_name}'"
  
  first_product_element.find('button[data-test*="add-to-cart"]').click
end

When('I add the last product {string} to the cart') do |expected_product_name|
  last_product_element = find('.inventory_item:last-child', wait: 5)
  actual_product_name = last_product_element.find('.inventory_item_name').text
  
  expect(actual_product_name).to eq(expected_product_name), 
    "Expected last product to be '#{expected_product_name}', but found '#{actual_product_name}'"
  
  last_product_element.find('button[data-test*="add-to-cart"]').click
end

When('I add the product {string} to the cart') do |product_name|
  product_element = find('.inventory_item', text: product_name, wait: 5)
  product_element.find('button[data-test*="add-to-cart"]').click
end

When('I remove {string} from the cart') do |product_name|
  product_element = find('.inventory_item', text: product_name, wait: 5)
  product_element.find('button[data-test*="remove"]').click
end

Then('the button for {string} should change to {string}') do |product_name, expected_button_text|
  product_element = find('.inventory_item', text: product_name, wait: 5)
  button = product_element.find('button', wait: 5)
  expect(button.text).to eq(expected_button_text)
end

Then('the button for {string} should remain {string}') do |product_name, expected_button_text|
  product_element = find('.inventory_item', text: product_name, wait: 5)
  button = product_element.find('button', wait: 5)
  expect(button.text).to eq(expected_button_text)
end

Then('the first product should remain {string}') do |expected_product_name|
  first_product_name = find('.inventory_item:first-child .inventory_item_name', wait: 5).text
  expect(first_product_name).to eq(expected_product_name)
end

Then('the last product should remain {string}') do |expected_product_name|
  last_product_name = find('.inventory_item:last-child .inventory_item_name', wait: 5).text
  expect(last_product_name).to eq(expected_product_name)
end

Then('all selected products should have {string} buttons') do |button_text|
  cart_count = find('.shopping_cart_badge', wait: 5).text.to_i
  remove_buttons = all('button[data-test*="remove"]').count
  expect(remove_buttons).to eq(cart_count), 
    "Expected #{cart_count} 'Remove' buttons, but found #{remove_buttons}"
end

When('I click on the cart link') do
  find('.shopping_cart_link', wait: 5).click
  expect(page).to have_selector('.cart_contents_container', wait: 5)
end

When('I click on the product title {string} in cart') do |product_name|
  within('.cart_contents_container') do
    find('.inventory_item_name', text: product_name, wait: 5).click
  end
end

Then('I should see the product details page for {string}') do |product_name|
  expect(page).to have_current_path(/inventory-item.html/, url: true)
  expect(page).to have_selector('.inventory_details_name', text: product_name, wait: 5)
end

Then('I should see the product price {string}') do |expected_price|
  actual_price = find('.inventory_details_price', wait: 5).text
  expect(actual_price).to eq(expected_price)
end

Then('I should see the product description contains {string}') do |description_text|
  description = find('.inventory_details_desc', wait: 5).text.downcase
  expect(description).to include(description_text.downcase)
end