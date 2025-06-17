# Filter Steps
require_relative '../pages/products_page'

products_page = ProductsPage.new

When('I select {string} from product sort') do |option|
  products_page.select_sort_option(option)
end

Then('products should be sorted alphabetically ascending') do
  expect(products_page.product_names).to eq(products_page.product_names.sort)
end

Then('products should be sorted alphabetically descending') do
  expect(products_page.product_names).to eq(products_page.product_names.sort.reverse)
end

Then('products should be sorted by price ascending') do
  expect(products_page.product_prices).to eq(products_page.product_prices.sort)
end

Then('products should be sorted by price descending') do
  expect(products_page.product_prices).to eq(products_page.product_prices.sort.reverse)
end