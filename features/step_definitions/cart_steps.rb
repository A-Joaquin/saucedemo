require_relative '../pages/cart_page'

cart_page = CartPage.new

When('I click on the add to cart button for {string}') do |item_name|
  cart_page.add_to_cart(item_name)
end

When('I click the remove button') do
  cart_page.click_remove_button
end

When('I click on the cart title {string}') do |product_name|
  cart_page.click_product_title(product_name)
end

Then('the button should change to {string}') do |button_text|
  expect(page).to have_button(button_text, wait: 5)
end

Then('the cart badge should be empty') do
  expect(cart_page.has_no_cart_badge?).to be true
end

Then('I should see detailed cart information') do
  expect(page).to have_css('.inventory_details_desc', wait: 5)
  expect(page).to have_css('.inventory_details_price', wait: 5)
end

Then('I should see the cart details page for {string}') do |product_name|
  expect(cart_page.on_cart_details_page_for?(product_name)).to be true
end

Then('the cart badge should show {string}') do |expected_count|
  expect(cart_page.has_cart_badge?(expected_count)).to be true
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
  cart_page.remove_from_cart(product_name)
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
  cart_page.click_cart_link
end

When('I click on the product title {string} in cart') do |product_name|
  within('.cart_contents_container') do
    find('.inventory_item_name', text: product_name, wait: 5).click
  end
end

Then('I should see the product details page for {string}') do |product_name|
  expect(cart_page.on_product_details_page_for?(product_name)).to be true
end

Then('I should see the product price {string}') do |expected_price|
  expect(cart_page.product_price).to eq(expected_price)
end

Then('I should see the product description contains {string}') do |description_text|
  expect(cart_page.product_description.downcase).to include(description_text.downcase)
end