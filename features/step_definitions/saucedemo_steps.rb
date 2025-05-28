# Login Steps
Given("I am on the SauceDemo login page") do
  visit "https://www.saucedemo.com/"
end

When("I enter valid credentials") do
  fill_in "user-name", with: "standard_user"
  fill_in "password", with: "secret_sauce"
end

When("I enter username {string} and password {string}") do |username, password|
  fill_in "user-name", with: username
  fill_in "password", with: password
end

When("I click the login button") do
  click_button "Login"
end

Then("I should see the inventory page") do
  expect(page).to have_content("Products")
end

Then("I should see error message {string}") do |error_message|
  expect(page).to have_content(error_message)
end

# Product and Cart Steps
# Product and Cart Steps
When("I add {string} to cart") do |product_name|
  product_element = find(".inventory_item", text: product_name)
  within(product_element) do
    click_button "Add to cart"
  end
end

Then("the cart badge should show {string}") do |count|
  expect(find(".shopping_cart_badge")).to have_content(count)
end

When("I click the cart") do
  click_link "shopping_cart_container"
end

Then("The item should be in the cart") do
  expect(page).to have_css(".cart_item")
end

When("I go to cart") do
  click_link "shopping_cart_container"
end

When("I remove {string} from cart") do |product_name|
  cart_item = find(".cart_item", text: product_name)
  within(cart_item) do
    click_button "Remove"
  end
end

Then("the cart should be empty") do
  expect(page).not_to have_css(".cart_item")
end

# Filter Steps
When("I select {string} from product sort") do |option|
  find(".product_sort_container").select(option)
end

Then("products should be sorted alphabetically ascending") do
  product_names = all(".inventory_item_name").map(&:text)
  expect(product_names).to eq(product_names.sort)
end

Then("products should be sorted alphabetically descending") do
  product_names = all(".inventory_item_name").map(&:text)
  expect(product_names).to eq(product_names.sort.reverse)
end

Then("products should be sorted by price ascending") do
  prices = all(".inventory_item_price").map { |price| price.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort)
end


Then("products should be sorted by price descending") do
  prices = all(".inventory_item_price").map { |price| price.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort.reverse)
end