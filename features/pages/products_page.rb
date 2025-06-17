class ProductsPage
  include Capybara::DSL

  SORT_CONTAINER = '.product_sort_container'
  PRODUCT_NAME = '.inventory_item_name'
  PRODUCT_PRICE = '.inventory_item_price'

  # Selecciona una opción de ordenamiento
  def select_sort_option(option)
    find(SORT_CONTAINER, wait: 5).select(option)
  end

  # Devuelve los nombres de los productos
  def product_names
    all(PRODUCT_NAME, wait: 5).map(&:text)
  end

  # Devuelve los precios de los productos
  def product_prices
    all(PRODUCT_PRICE, wait: 5).map { |price| price.text.gsub('$', '').to_f }
  end
end 