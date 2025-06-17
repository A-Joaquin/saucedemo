class ProductsPage
  include Capybara::DSL

  def select_sort_option(option)
    find('.product_sort_container').select(option)
  end

  def product_names
    all('.inventory_item_name').map(&:text)
  end

  def product_prices
    all('.inventory_item_price').map { |price| price.text.gsub('$', '').to_f }
  end
end 