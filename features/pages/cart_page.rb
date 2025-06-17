class CartPage
  include Capybara::DSL

  CART_LINK = '.shopping_cart_link'
  CART_CONTAINER = '.cart_contents_container'
  CART_BADGE = '.shopping_cart_badge'
  REMOVE_BUTTON = 'button[data-test*="remove"]'
  ADD_TO_CART_XPATH = "//div[text()='%{item_name}']/ancestor::div[@class='inventory_item']//button[contains(text(), 'Add to cart')]"
  PRODUCT_ITEM = '.inventory_item'
  PRODUCT_NAME = '.inventory_item_name'
  PRODUCT_DETAILS_NAME = '.inventory_details_name'
  PRODUCT_DETAILS_PRICE = '.inventory_details_price'
  PRODUCT_DETAILS_DESC = '.inventory_details_desc'
  PRODUCT_DETAILS_PATH = /inventory-item.html/

  # Agrega un producto al carrito por nombre
  def add_product_to_cart(item_name)
    find(:xpath, ADD_TO_CART_XPATH % {item_name: item_name}, wait: 5).click
  end

  # Remueve un producto del carrito por nombre
  def remove_product_from_cart(item_name)
    product_element = find(PRODUCT_ITEM, text: item_name, wait: 5)
    product_element.find(REMOVE_BUTTON, wait: 5).click
  end

  # Hace clic en el ícono del carrito
  def open_cart
    find(CART_LINK, wait: 5).click
  end

  # Devuelve el texto del badge del carrito
  def cart_badge_text
    badge = first(CART_BADGE, wait: 5)
    badge ? badge.text : nil
  end

  # Hace clic en el botón Remove (genérico)
  def click_remove_button
    click_button('Remove', wait: 5)
  end

  # Hace clic en el nombre de un producto
  def click_product_name(product_name)
    find(PRODUCT_NAME, text: product_name, wait: 5).click
  end

  # Devuelve true si está en la página de detalles del producto
  def on_product_details_page?(product_name)
    page.has_current_path?(PRODUCT_DETAILS_PATH, url: true, wait: 5) && has_selector?(PRODUCT_DETAILS_NAME, text: product_name, wait: 5)
  end

  # Devuelve true si está en la página de detalles del carrito
  def on_cart_details_page?(product_name)
    has_css?(PRODUCT_DETAILS_NAME, text: product_name, wait: 5)
  end

  # Devuelve el precio del producto en detalles
  def product_details_price
    find(PRODUCT_DETAILS_PRICE, wait: 5).text
  end

  # Devuelve la descripción del producto en detalles
  def product_details_description
    find(PRODUCT_DETAILS_DESC, wait: 5).text
  end

  # Devuelve true si el badge del carrito está vacío
  def cart_badge_empty?
    has_no_css?(CART_BADGE, wait: 5)
  end

  # Devuelve true si el badge del carrito tiene el valor esperado
  def cart_badge_has_count?(count)
    has_css?(CART_BADGE, text: count, wait: 5)
  end
end 