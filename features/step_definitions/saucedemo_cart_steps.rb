When('I click on the add to cart button for {string}') do |item_name|
  find(:xpath, "//div[text()='#{item_name}']/ancestor::div[@class='inventory_item']//button[contains(text(), 'Add to cart')]").click
end

Then('the cart badge should show {string}') do |number|
  expect(page).to have_css('.shopping_cart_badge', text: number, wait: 5)
end

Then('the button should change to {string}') do |button_text|
  expect(page).to have_button(button_text, wait: 5)
end

Given('I have added {string} to the cart') do |item_name|
  step "I click on the add to cart button for \"#{item_name}\""
end

When('I click the remove button') do
  click_button('Remove')
end

Then('the cart badge should be empty') do
  expect(page).not_to have_css('.shopping_cart_badge', wait: 5)
end

When('I click on the cart title {string}') do |product_name|
  find('.inventory_item_name', text: product_name).click
end

Then('I should see the cart details page for {string}') do |product_name|
  expect(page).to have_css('.inventory_details_name', text: product_name, wait: 5)
end

Then('I should see detailed cart information') do
  expect(page).to have_css('.inventory_details_desc', wait: 5)
  expect(page).to have_css('.inventory_details_price', wait: 5)
end
