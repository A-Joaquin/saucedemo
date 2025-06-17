# Filter Steps
require_relative '../pages/products_page'

products_page = ProductsPage.new

When('I select {string} from product sort') do |option|
  products_page.select_sort_option(option)
end

Then('products should be sorted alphabetically ascending') do
  names = products_page.product_names
  expect(names).to eq(names.sort)
end

Then('products should be sorted alphabetically descending') do
  names = products_page.product_names
  expect(names).to eq(names.sort.reverse)
end

Then('products should be sorted by price ascending') do
  prices = products_page.product_prices
  expect(prices).to eq(prices.sort)
end

Then('products should be sorted by price descending') do
  prices = products_page.product_prices
  expect(prices).to eq(prices.sort.reverse)
end