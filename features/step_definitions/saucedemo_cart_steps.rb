When('I click on the add to cart button for {string}') do |item_name|
  sleep 1
  find(:xpath, "//div[text()='#{item_name}']/ancestor::div[@class='inventory_item']//button[text()='Add to cart']").click
  sleep 1
end

Then('the cart badge should show {string}') do |number|
  expect(page).to have_css('.shopping_cart_badge', text: number)
  sleep 1
end

Then('the button should change to {string}') do |button_text|
  expect(page).to have_button(button_text)
  sleep 1
end

Given('I have added {string} to the cart') do |item_name|
  step "I click on the add to cart button for \"#{item_name}\""
  sleep 1
end

When('I click the remove button') do
  click_button 'Remove'
  sleep 1
end

Then('the cart badge should be empty') do
  expect(page).not_to have_css('.shopping_cart_badge')
  sleep 1
end

When('I click on the cart title {string}') do |product_name|
  find('.inventory_item_name', text: product_name).click
  sleep 1
end

Then('I should see the cart details page for {string}') do |product_name|
  expect(page).to have_css('.inventory_details_name', text: product_name)
  sleep 1
end

Then('I should see detailed cart information') do
  expect(page).to have_css('.inventory_details_desc')
  expect(page).to have_css('.inventory_details_price')
  sleep 1
end
