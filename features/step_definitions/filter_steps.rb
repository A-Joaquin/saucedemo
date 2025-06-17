# Filter Steps
When('I select {string} from product sort') do |option|
  find('.product_sort_container').select(option)
end

Then('products should be sorted alphabetically ascending') do
  product_names = all('.inventory_item_name').map(&:text)
  expect(product_names).to eq(product_names.sort)
end

Then('products should be sorted alphabetically descending') do
  product_names = all('.inventory_item_name').map(&:text)
  expect(product_names).to eq(product_names.sort.reverse)
end

Then('products should be sorted by price ascending') do
  prices = all('.inventory_item_price').map { |price| price.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort)
end

Then('products should be sorted by price descending') do
  prices = all('.inventory_item_price').map { |price| price.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort.reverse)
end