class CheckoutPage
  include Capybara::DSL

  CART_LINK = '.shopping_cart_link'
  CART_CONTAINER = '.cart_contents_container'
  CHECKOUT_BTN = '#checkout'
  CONTINUE_BTN = '#continue'
  FINISH_BTN = '#finish'
  CANCEL_BTN = '#cancel'
  FIRST_NAME_FIELD = 'first-name'
  LAST_NAME_FIELD = 'last-name'
  POSTAL_CODE_FIELD = 'postal-code'
  ERROR_MESSAGE = '[data-test="error"]'
  COMPLETE_HEADER = '.complete-header'
  CART_ITEM = '.cart_item'
  CART_ITEM_NAME = '.cart_item .inventory_item_name'
  SUMMARY_SUBTOTAL = '.summary_subtotal_label'
  INVENTORY_ITEM_PRICE = '.inventory_item_price'
  CONTINUE_SHOPPING_BTN = '#continue-shopping'
  CHECKOUT_STEP_ONE_PATH = /checkout-step-one.html/
  CHECKOUT_STEP_TWO_PATH = /checkout-step-two.html/
  CHECKOUT_COMPLETE_PATH = /checkout-complete.html/

  # Inicia el proceso de checkout
  def start_checkout
    find(CART_LINK, wait: 5).click
    find(CART_CONTAINER, wait: 5)
    find(CHECKOUT_BTN, wait: 5).click
  end

  # Llena el formulario de información de checkout
  def fill_checkout_info(first_name, last_name, postal_code)
    fill_in FIRST_NAME_FIELD, with: first_name
    fill_in LAST_NAME_FIELD, with: last_name
    fill_in POSTAL_CODE_FIELD, with: postal_code
  end

  # Continúa al resumen de checkout
  def continue_to_overview
    find(CONTINUE_BTN, wait: 5).click
  end

  # Intenta continuar al resumen (sin validar redirección)
  def attempt_continue_to_overview
    find(CONTINUE_BTN, wait: 5).click
  end

  # Finaliza la compra
  def finish_checkout
    find(FINISH_BTN, wait: 5).click
  end

  # Cancela el proceso de checkout
  def cancel_checkout
    find(CANCEL_BTN, wait: 5).click
  end

  # Devuelve el mensaje de confirmación de la orden
  def order_confirmation_message
    find(COMPLETE_HEADER, wait: 5).text
  end

  # Devuelve los nombres de los productos en el carrito
  def cart_item_names
    all(CART_ITEM_NAME, wait: 5).map(&:text)
  end

  # Devuelve la cantidad de productos en el carrito
  def cart_item_count
    all(CART_ITEM, wait: 5).count
  end

  # Devuelve el texto del subtotal
  def subtotal_label
    find(SUMMARY_SUBTOTAL, wait: 5).text
  end

  # Devuelve el valor numérico del subtotal
  def subtotal_value
    subtotal_label.match(/\$(\d+\.\d+)/)[1].to_f
  end

  # Devuelve los precios individuales de los productos
  def individual_prices
    all(INVENTORY_ITEM_PRICE, wait: 5).map { |el| el.text.gsub('$', '').to_f }
  end

  # Abre el carrito
  def open_cart
    find(CART_LINK, wait: 5).click
  end

  # Hace clic en continuar comprando si está disponible
  def continue_shopping_if_possible
    find(CONTINUE_SHOPPING_BTN, wait: 5).click if page.has_selector?(CONTINUE_SHOPPING_BTN, wait: 1)
  end

  # Devuelve true si está en la página de información de checkout
  def on_checkout_info_page?
    page.has_current_path?(CHECKOUT_STEP_ONE_PATH, url: true, wait: 5) && page.has_content?('Checkout: Your Information', wait: 5)
  end

  def has_validation_error?(msg)
    page.has_selector?(ERROR_MESSAGE, text: msg, wait: 5)
  end

  def has_cart_item?(product_name)
    within('.cart_list') do
      page.has_selector?(CART_ITEM_NAME, text: product_name, wait: 5)
    end
  end

  def has_cart_product?(product_name)
    within(CART_CONTAINER) do
      page.has_selector?(CART_ITEM_NAME, text: product_name, wait: 5)
    end
  end
end 